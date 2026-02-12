import 'package:flutter/material.dart';
import '../models/official.dart';
import '../utils/responsive_utils.dart';

class OfficialCard extends StatelessWidget {
  final Official official;
  final VoidCallback? onTap;

  const OfficialCard({
    super.key,
    required this.official,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final margin = ResponsiveUtils.getMargin(
      context,
      mobile: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      tablet: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      desktop: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
    );
    final avatarRadius = ResponsiveUtils.getIconSize(
      context,
      mobile: 20.0,
      tablet: 24.0,
      desktop: 28.0,
    );
    final iconSize = ResponsiveUtils.getIconSize(
      context,
      mobile: 20.0,
      tablet: 22.0,
      desktop: 24.0,
    );
    final titleFontSize = ResponsiveUtils.getFontSize(
      context,
      mobile: 16.0,
      tablet: 17.0,
      desktop: 18.0,
    );
    final subtitleFontSize = ResponsiveUtils.getFontSize(
      context,
      mobile: 14.0,
      tablet: 15.0,
      desktop: 16.0,
    );

    return Card(
      elevation: 1,
      margin: margin,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.getPadding(
            context,
            mobile: 16.0,
            tablet: 20.0,
            desktop: 24.0,
          ),
          vertical: ResponsiveUtils.getSpacing(
            context,
            mobile: 8.0,
            tablet: 10.0,
            desktop: 12.0,
          ),
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          radius: avatarRadius,
          child: Text(
            official.name.isNotEmpty ? official.name[0] : '?',
            style: TextStyle(
              color: Colors.white,
              fontSize: titleFontSize,
            ),
          ),
        ),
        title: Text(
          official.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: titleFontSize,
          ),
        ),
        subtitle: Text(
          '${official.role} • ${official.service}',
          style: TextStyle(fontSize: subtitleFontSize),
        ),
        trailing: Icon(Icons.chevron_right, size: iconSize),
        onTap: onTap,
      ),
    );
  }
}
