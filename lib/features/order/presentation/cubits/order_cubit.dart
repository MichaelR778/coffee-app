import 'dart:async';

import 'package:coffee_app/features/auth/domain/auth_repo.dart';
import 'package:coffee_app/features/order/domain/entities/order.dart';
import 'package:coffee_app/features/order/domain/repos/order_repo.dart';
import 'package:coffee_app/features/order/presentation/cubits/order_state.dart';
import 'package:coffee_app/user/cart/domain/entities/cart_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepo orderRepo;
  final AuthRepo authRepo;
  StreamSubscription? orderSubscription;

  OrderCubit({
    required this.orderRepo,
    required this.authRepo,
  }) : super(OrderLoading());

  void loadUserOrder() {
    try {
      emit(OrderLoading());

      orderSubscription?.cancel();

      orderSubscription =
          orderRepo.getUserOrderStream(authRepo.getUserId()).listen(
        (orders) {
          emit(OrderLoaded(orders: orders));
        },
        onError: (error) {
          emit(OrderError(message: error.toString()));
        },
        cancelOnError: true,
      );
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  void loadAllOrder() {
    try {
      emit(OrderLoading());

      orderSubscription?.cancel();

      orderSubscription = orderRepo.getAllOrderStream().listen(
        (orders) {
          emit(OrderLoaded(orders: orders));
        },
        onError: (error) {
          emit(OrderError(message: error.toString()));
        },
        cancelOnError: true,
      );
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  Future<void> placeOrder(List<CartItem> cartItems) async {
    try {
      final newOrder = Order(
        id: -1,
        userId: authRepo.getUserId(),
        cartItems: cartItems,
        status: OrderStatus.pending,
        createdAt: DateTime.now(),
      );
      await orderRepo.placeOrder(newOrder);
    } catch (e) {
      emit(OrderError(message: e.toString()));
      // user failed to place order, re load to change from error state
      loadUserOrder();
    }
  }

  Future<void> cancelOrder(int orderId) async {
    try {
      await orderRepo.cancelOrder(orderId);
    } catch (e) {
      emit(OrderError(message: e.toString()));
    } finally {
      // only user can cancel their own order
      // therefore loaduserorder is used
      loadUserOrder();
    }
  }

  /*

  Update order status by admin / coffee store worker

  */

  Future<void> acceptOrder(int orderId) async {
    try {
      await orderRepo.acceptOrder(orderId);
    } catch (e) {
      emit(OrderError(message: e.toString()));
      // override error state
      loadAllOrder();
    }
  }

  Future<void> orderReady(int orderId) async {
    try {
      await orderRepo.orderReady(orderId);
    } catch (e) {
      emit(OrderError(message: e.toString()));
      // override error state
      loadAllOrder();
    }
  }

  Future<void> finishOrder(int orderId) async {
    try {
      await orderRepo.finishOrder(orderId);
    } catch (e) {
      emit(OrderError(message: e.toString()));
      // override error state
      loadAllOrder();
    }
  }
}
