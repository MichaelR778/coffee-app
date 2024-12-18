import 'package:coffee_app/features/order/domain/entities/order.dart';
import 'package:coffee_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OrderStatusTimeline extends StatelessWidget {
  final Order order;
  final bool admin;

  const OrderStatusTimeline({
    super.key,
    required this.order,
    this.admin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTimelineTile(
          status: OrderStatus.pending,
          title: 'Order Placed',
          subtitle: '${admin ? 'Order' : 'Your order'} is being processed',
          time: order.createdAt,
          icon: Icons.pending_outlined,
          isFirst: true,
        ),
        _buildTimelineTile(
          status: OrderStatus.brewing,
          title: 'Brewing',
          subtitle: '${admin ? 'Order' : 'Your order'} is being prepared',
          time: order.acceptedAt,
          icon: Icons.coffee_outlined,
        ),
        _buildTimelineTile(
          status: OrderStatus.ready,
          title: 'Ready for Pickup',
          subtitle: '${admin ? 'Order' : 'Your order'} is ready to collect',
          time: order.readyAt,
          icon: Icons.check_circle_outline,
        ),
        _buildTimelineTile(
          status: OrderStatus.finished,
          title: 'Order Completed',
          subtitle: admin
              ? 'The order has been successfully fulfilled'
              : 'Thank you for your purchase',
          time: order.finishedAt,
          icon: Icons.done_all,
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildTimelineTile({
    required OrderStatus status,
    required String title,
    required String subtitle,
    required DateTime? time,
    required IconData icon,
    bool isFirst = false,
    bool isLast = false,
  }) {
    final bool isStatusReached = order.status.index >= status.index;
    final Color statusColor = _getStatusColor(status);

    return TimelineTile(
      axis: TimelineAxis.vertical,
      alignment: TimelineAlign.start,
      isFirst: isFirst,
      isLast: isLast,
      indicatorStyle: IndicatorStyle(
        width: 30,
        color: isStatusReached ? statusColor : Colors.grey.shade300,
        iconStyle: IconStyle(
          color: Colors.white,
          iconData: icon,
        ),
      ),
      beforeLineStyle: LineStyle(
        color: isStatusReached ? statusColor : Colors.grey.shade300,
      ),
      endChild: _buildStatusCard(
        title: title,
        subtitle: subtitle,
        time: time,
        status: status,
      ),
    );
  }

  Widget _buildStatusCard({
    required String title,
    required String subtitle,
    required DateTime? time,
    required OrderStatus status,
  }) {
    final bool isStatusReached = order.status.index >= status.index;
    final Color statusColor = _getStatusColor(status);

    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isStatusReached
            ? statusColor.withOpacity(0.1)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isStatusReached ? statusColor : Colors.grey,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: isStatusReached ? Colors.black87 : Colors.grey,
            ),
          ),
          if (time != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                _formatDateTime(time),
                style: TextStyle(
                  fontSize: 12,
                  color: isStatusReached ? Colors.black54 : Colors.grey,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MMM d, yyyy - HH:mm a').format(dateTime);
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange.shade200;
      case OrderStatus.brewing:
        return Colors.orange;
      case OrderStatus.ready:
        return Colors.green;
      case OrderStatus.finished:
        return AppColors.primary;
    }
  }
}
