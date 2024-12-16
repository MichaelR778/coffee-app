import 'dart:io';

import 'package:coffee_app/admin/image/domain/image_repo.dart';
import 'package:coffee_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseImageRepo implements ImageRepo {
  @override
  Future<String> uploadImage(String filePath, String fileName) async {
    try {
      final file = File(filePath);
      await supabase.storage.from('items').upload(
            '$fileName.png',
            file,
            fileOptions: const FileOptions(upsert: true),
          );
      String imageUrl =
          supabase.storage.from('items').getPublicUrl('$fileName.png');
      imageUrl = Uri.parse(imageUrl).replace(queryParameters: {
        't': DateTime.now().millisecondsSinceEpoch.toString()
      }).toString();
      return imageUrl;
    } catch (e) {
      throw Exception('Failed uploading profile picture: $e');
    }
  }
}
