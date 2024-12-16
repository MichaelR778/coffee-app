import 'dart:async';

import 'package:coffee_app/admin/image/domain/image_repo.dart';
import 'package:coffee_app/features/item/domain/entities/item.dart';
import 'package:coffee_app/features/item/domain/repos/item_repo.dart';
import 'package:coffee_app/features/item/presentation/cubits/item_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemCubit extends Cubit<ItemState> {
  final ItemRepo itemRepo;
  final ImageRepo imageRepo;
  StreamSubscription? itemSubscription;

  ItemCubit({
    required this.itemRepo,
    required this.imageRepo,
  }) : super(ItemInitial());

  // void init() => loadItem();

  void loadItem() {
    try {
      emit(ItemLoading());

      itemSubscription?.cancel();

      itemSubscription = itemRepo.getItemStream().listen(
        (items) {
          emit(ItemLoaded(items: items));
        },
        onError: (error) {
          emit(ItemError(message: error.toString()));
        },
        cancelOnError: true,
      );
    } catch (e) {
      emit(ItemError(message: e.toString()));
    }
  }

  Future<void> addItem(
    String name,
    String description,
    double price,
    String imagePath,
  ) async {
    try {
      final imageUrl = await imageRepo.uploadImage(imagePath, '${name}_image');
      final newItem = Item(
        id: -1,
        name: name,
        description: description,
        price: price,
        imageUrl: imageUrl,
      );
      await itemRepo.addItem(newItem);
    } catch (e) {
      emit(ItemError(message: e.toString()));
      loadItem();
    }
  }
}
