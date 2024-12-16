import 'package:coffee_app/app.dart';
import 'package:coffee_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  final String text;
  final Future<void> Function() callback;

  const LoadingButton({
    super.key,
    required this.text,
    required this.callback,
  });

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool _loading = false;

  void execute() async {
    try {
      setState(() {
        _loading = true;
      });
      await widget.callback();
    } catch (e) {
      if (mounted) {
        context.showSnackBar(e.toString());
      }
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _loading ? null : execute,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: _loading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  widget.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
