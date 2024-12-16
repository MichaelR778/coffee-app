import 'package:coffee_app/features/item/domain/entities/item.dart';

abstract class ItemState {}

class ItemInitial extends ItemState {}

class ItemLoading extends ItemState {}

class ItemLoaded extends ItemState {
  final List<Item> items;

  ItemLoaded({required this.items});
}

class ItemError extends ItemState {
  final String message;

  ItemError({required this.message});
}
