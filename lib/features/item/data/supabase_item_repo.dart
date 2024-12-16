import 'package:coffee_app/features/item/domain/entities/item.dart';
import 'package:coffee_app/features/item/domain/repos/item_repo.dart';
import 'package:coffee_app/main.dart';

class SupabaseItemRepo implements ItemRepo {
  @override
  Stream<List<Item>> getItemStream() {
    return supabase.from('items').stream(primaryKey: ['id']).map(
        (jsons) => jsons.map((json) => Item.fromJson(json)).toList());
  }

  @override
  Future<void> addItem(Item item) async {
    try {
      await supabase.from('items').insert({
        'name': item.name,
        'description': item.description,
        'price': item.price,
        'image_url': item.imageUrl,
      });
    } catch (e) {
      throw Exception('Failed to add item to database: $e');
    }
  }

  @override
  Future<Item> getItem(int id) async {
    try {
      final json = await supabase.from('items').select().eq('id', id).single();
      return Item.fromJson(json);
    } catch (e) {
      throw Exception('Failed to get item by id: $e');
    }
  }
}
