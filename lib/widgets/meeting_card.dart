import 'package:flutter/material.dart';
import '../models/meeting.dart';
import '../utils/responsive_utils.dart';

class MeetingCard extends StatelessWidget {
  final Meeting meeting;
  final VoidCallback onTap;

  const MeetingCard({
    super.key,
    required this.meeting,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final margin = ResponsiveUtils.getMargin(
      context,
      mobile: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tablet: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      desktop: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
    );
    final padding = ResponsiveUtils.getPadding(
      context,
      mobile: 16.0,
      tablet: 20.0,
      desktop: 24.0,
    );
    final iconSize = ResponsiveUtils.getIconSize(
      context,
      mobile: 20.0,
      tablet: 22.0,
      desktop: 24.0,
    );
    final smallIconSize = ResponsiveUtils.getIconSize(
      context,
      mobile: 16.0,
      tablet: 18.0,
      desktop: 20.0,
    );
    final dateFontSize = ResponsiveUtils.getFontSize(
      context,
      mobile: 14.0,
      tablet: 15.0,
      desktop: 16.0,
    );
    final titleFontSize = ResponsiveUtils.getFontSize(
      context,
      mobile: 18.0,
      tablet: 20.0,
      desktop: 22.0,
    );
    final detailFontSize = ResponsiveUtils.getFontSize(
      context,
      mobile: 14.0,
      tablet: 15.0,
      desktop: 16.0,
    );
    final spacing = ResponsiveUtils.getSpacing(
      context,
      mobile: 8.0,
      tablet: 10.0,
      desktop: 12.0,
    );

    return Card(
      margin: margin,
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.event,
                    color: theme.primaryColor,
                    size: iconSize,
                  ),
                  SizedBox(width: spacing),
                  Text(
                    meeting.date,
                    style: TextStyle(
                      fontSize: dateFontSize,
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacing),
              Text(
                meeting.title,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spacing + 4),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: smallIconSize,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      meeting.venue,
                      style: TextStyle(
                        fontSize: detailFontSize,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.people,
                    size: smallIconSize,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                  SizedBox(width: 4),
                  Text(
                    '${meeting.attendance} members present',
                    style: TextStyle(
                      fontSize: detailFontSize,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
