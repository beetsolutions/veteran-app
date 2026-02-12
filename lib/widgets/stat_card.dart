import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveUtils.getPadding(
      context,
      mobile: 16.0,
      tablet: 20.0,
      desktop: 24.0,
    );
    final iconSize = ResponsiveUtils.getIconSize(
      context,
      mobile: 32.0,
      tablet: 36.0,
      desktop: 40.0,
    );
    final spacing = ResponsiveUtils.getSpacing(
      context,
      mobile: 12.0,
      tablet: 14.0,
      desktop: 16.0,
    );
    final titleFontSize = ResponsiveUtils.getFontSize(
      context,
      mobile: 14.0,
      tablet: 15.0,
      desktop: 16.0,
    );
    final valueFontSize = ResponsiveUtils.getFontSize(
      context,
      mobile: 28.0,
      tablet: 32.0,
      desktop: 36.0,
    );

    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: iconSize),
                SizedBox(width: spacing),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spacing),
            Text(
              value,
              style: TextStyle(
                fontSize: valueFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
