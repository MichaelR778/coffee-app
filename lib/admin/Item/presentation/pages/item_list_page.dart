import 'package:coffee_app/admin/Item/presentation/pages/add_item_page.dart';
import 'package:coffee_app/admin/Item/presentation/widgets/admin_item_card.dart';
import 'package:coffee_app/app.dart';
import 'package:coffee_app/features/item/presentation/cubits/item_cubit.dart';
import 'package:coffee_app/features/item/presentation/cubits/item_state.dart';
import 'package:coffee_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemListPage extends StatelessWidget {
  const ItemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item List'),
        actions: [
          IconButton(
            color: AppColors.primary,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddItemPage(),
              ),
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocConsumer<ItemCubit, ItemState>(
        builder: (context, state) {
          // loading
          if (state is ItemLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // loaded
          else if (state is ItemLoaded) {
            final items = state.items;

            if (items.isEmpty) {
              return const Center(child: Text('No item found'));
            }

            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                mainAxisSpacing: 24,
                crossAxisSpacing: 15,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return AdminItemCard(item: item);
              },
            );
          }

          // error
          else if (state is ItemError) {
            return Center(child: Text(state.message));
          }

          // other
          return const Center(
            child: Text('Something went wrong'),
          );
        },
        listener: (context, state) {
          if (state is ItemError) {
            context.showSnackBar(state.message);
          }
        },
      ),
    );
  }
}
