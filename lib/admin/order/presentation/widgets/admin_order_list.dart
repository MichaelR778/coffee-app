import 'package:coffee_app/admin/order/presentation/pages/admin_order_detail_page.dart';
import 'package:coffee_app/features/order/domain/entities/order.dart';
import 'package:coffee_app/features/order/presentation/cubits/order_cubit.dart';
import 'package:coffee_app/features/order/presentation/cubits/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminOrderList extends StatelessWidget {
  final bool finished;

  const AdminOrderList({super.key, required this.finished});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        // loading
        if (state is OrderLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // loaded
        else if (state is OrderLoaded) {
          final orders = state.orders
              .where((order) => finished
                  ? order.status == OrderStatus.finished
                  : order.status != OrderStatus.finished)
              .toList();

          // no order ongoing
          if (orders.isEmpty) {
            return Center(
              child: Text('No order ${finished ? 'finished' : 'ongoing'}'),
            );
          }

          return ListView.separated(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    order.cartItems[0].item.imageUrl,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(),
                  ),
                ),
                title: Text('Order #${order.id}'),
                subtitle: Text(
                  order.status.name,
                  style: TextStyle(
                    color: order.getStatusColor(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminOrderDetailPage(order: order),
                  ),
                ),
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
    );
  }
}
