import 'package:coffee_app/features/item/domain/entities/item.dart';

abstract class ItemRepo {
  Stream<List<Item>> getItemStream();
  Future<void> addItem(Item item);
  Future<Item> getItem(int id);
}
