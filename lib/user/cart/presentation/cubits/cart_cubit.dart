import 'dart:async';

import 'package:coffee_app/features/auth/domain/auth_repo.dart';
import 'package:coffee_app/features/item/domain/repos/item_repo.dart';
import 'package:coffee_app/user/cart/domain/entities/cart_item.dart';
import 'package:coffee_app/user/cart/domain/repos/cart_repo.dart';
import 'package:coffee_app/user/cart/presentation/cubits/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepo;
  final ItemRepo itemRepo;
  final AuthRepo authRepo;
  StreamSubscription? cartSubscription;

  CartCubit({
    required this.cartRepo,
    required this.itemRepo,
    required this.authRepo,
  }) : super(CartLoading());

  void loadCart() {
    try {
      // emit(CartLoading());

      cartSubscription?.cancel();

      cartSubscription = cartRepo.getCartStream(authRepo.getUserId()).listen(
        (jsons) async {
          try {
            final List<CartItem> cartItems = [];
            for (final json in jsons) {
              final item = await itemRepo.getItem(json['item_id']);
              final quantity = json['quantity'];
              cartItems.add(CartItem(item: item, quantity: quantity));
            }
            emit(CartLoaded(cartItems: cartItems));
          } catch (e) {
            emit(CartError(message: e.toString()));
          }
        },
        cancelOnError: true,
      );
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> addToCart(int itemId) async {
    try {
      final userId = authRepo.getUserId();
      await cartRepo.addToCart(userId, itemId);
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> subtractFromCart(int itemId) async {
    try {
      final userId = authRepo.getUserId();
      await cartRepo.subtractFromCart(userId, itemId);
    } catch (e) {
      emit(CartError(message: e.toString()));
    } finally {
      loadCart();
    }
  }

  Future<void> clearCart() async {
    try {
      await cartRepo.clearCart(authRepo.getUserId());
    } catch (e) {
      emit(CartError(message: e.toString()));
    } finally {
      loadCart();
    }
  }
}
