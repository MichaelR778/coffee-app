import 'package:coffee_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OrderTypeButton extends StatelessWidget {
  final String text;
  final int index;
  final int selectedIndex;
  final void Function() onTap;

  const OrderTypeButton({
    super.key,
    required this.text,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color:
              index == selectedIndex ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: index == selectedIndex ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight:
                  index == selectedIndex ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
