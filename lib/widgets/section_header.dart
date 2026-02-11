import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onShowAllPressed;

  const SectionHeader({
    super.key,
    required this.title,
    this.onShowAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (onShowAllPressed != null)
            TextButton(
              onPressed: onShowAllPressed,
              child: const Text('Show All'),
            ),
        ],
      ),
    );
  }
}
