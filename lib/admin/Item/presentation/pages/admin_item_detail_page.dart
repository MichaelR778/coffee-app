import 'package:coffee_app/features/item/domain/entities/item.dart';
import 'package:coffee_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AdminItemDetailPage extends StatelessWidget {
  final Item item;

  const AdminItemDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    const double spacing = 24;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Item Detail'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(spacing),
        children: [
          // image
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox();
                },
              ),
            ),
          ),

          const SizedBox(height: 15),

          // item name
          Text(
            item.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const Divider(
            color: AppColors.grey,
          ),

          // desc
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            item.description,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
