import 'package:coffee_app/features/item/presentation/cubits/item_cubit.dart';
import 'package:coffee_app/features/item/presentation/cubits/item_state.dart';
import 'package:coffee_app/theme/app_colors.dart';
import 'package:coffee_app/user/cart/presentation/pages/cart_page.dart';
import 'package:coffee_app/user/home/presentation/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const double spacing = 24;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // gradient container at the top
            Container(
              height: 280,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    AppColors.black,
                    AppColors.darkGrey,
                  ],
                ),
              ),
            ),

            // page content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(spacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Store Location',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const Text(
                      'Bilzen, Tanjungbalai',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: spacing),

                    // search field and button
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: const Color(0xff2A2A2A),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              hintText: 'Search coffee',
                              hintStyle: TextStyle(color: Colors.grey.shade600),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: spacing),
                        FloatingActionButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartPage(),
                            ),
                          ),
                          child: const Icon(Icons.shopping_cart_outlined),
                        ),
                      ],
                    ),

                    const SizedBox(height: spacing),

                    // banner
                    Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/images/Banner.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(height: spacing),

                    // item list
                    BlocBuilder<ItemCubit, ItemState>(
                      builder: (context, state) {
                        // loading
                        if (state is ItemLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        // loaded
                        else if (state is ItemLoaded) {
                          final items = state.items;
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.6,
                              mainAxisSpacing: spacing,
                              crossAxisSpacing: 15,
                            ),
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final item = items[index];
                              return ItemCard(item: item);
                            },
                          );
                        }

                        // other
                        return const Center(
                          child: Text('Oops, something went wrong'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
