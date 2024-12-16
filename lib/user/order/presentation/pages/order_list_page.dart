import 'package:coffee_app/app.dart';
import 'package:coffee_app/features/order/presentation/cubits/order_cubit.dart';
import 'package:coffee_app/features/order/presentation/cubits/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order List'),
      ),
      body: BlocConsumer<OrderCubit, OrderState>(
        builder: (context, state) {
          // loading
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // loaded
          else if (state is OrderLoaded) {
            final orders = state.orders;

            // no order ongoing
            if (orders.isEmpty) {
              return const Center(
                child: Text('No order ongoing'),
              );
            }

            return ListView.separated(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  title: Text('Order #${order.id}'),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            );
          }

          // other
          return const Center(
            child: Text('Oops, something went wrong'),
          );
        },
        listener: (context, state) {
          if (state is OrderError) {
            context.showSnackBar(state.message);
          }
        },
      ),
    );
  }
}
