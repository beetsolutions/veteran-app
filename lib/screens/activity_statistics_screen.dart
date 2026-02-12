import 'package:flutter/material.dart';
import '../widgets/stat_card.dart';
import '../utils/responsive_utils.dart';

class ActivityStatisticsScreen extends StatelessWidget {
  const ActivityStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveUtils.getPadding(
      context,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    );
    final titleFontSize = ResponsiveUtils.getFontSize(
      context,
      mobile: 24.0,
      tablet: 28.0,
      desktop: 32.0,
    );
    final spacing = ResponsiveUtils.getSpacing(
      context,
      mobile: 16.0,
      tablet: 20.0,
      desktop: 24.0,
    );
    final cardSpacing = ResponsiveUtils.getSpacing(
      context,
      mobile: 16.0,
      tablet: 20.0,
      desktop: 24.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Statistics'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Overview',
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spacing),
              _buildResponsiveGrid(
                context,
                [
                  StatCard(
                    title: 'Total Members',
                    value: '150',
                    icon: Icons.people,
                    iconColor: Colors.deepPurple,
                  ),
                  StatCard(
                    title: 'Active Members',
                    value: '142',
                    icon: Icons.person_outline,
                    iconColor: Colors.green,
                  ),
                  StatCard(
                    title: 'Events This Month',
                    value: '12',
                    icon: Icons.event,
                    iconColor: Colors.orange,
                  ),
                  StatCard(
                    title: 'Account Balance',
                    value: '\$25,000',
                    icon: Icons.account_balance_wallet,
                    iconColor: Colors.green,
                  ),
                ],
                cardSpacing,
              ),
              SizedBox(height: spacing + 8),
              Text(
                'Engagement',
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spacing),
              _buildResponsiveGrid(
                context,
                [
                  StatCard(
                    title: 'Event Attendance',
                    value: '85%',
                    icon: Icons.check_circle,
                    iconColor: Colors.deepPurple,
                  ),
                  StatCard(
                    title: 'Volunteer Hours',
                    value: '320',
                    icon: Icons.volunteer_activism,
                    iconColor: Colors.purple,
                  ),
                  StatCard(
                    title: 'New Members',
                    value: '8',
                    icon: Icons.person_add,
                    iconColor: Colors.teal,
                  ),
                  StatCard(
                    title: 'Meetings Held',
                    value: '4',
                    icon: Icons.groups,
                    iconColor: Colors.indigo,
                  ),
                ],
                cardSpacing,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResponsiveGrid(
    BuildContext context,
    List<Widget> cards,
    double spacing,
  ) {
    final columns = ResponsiveUtils.getGridColumns(
      context,
      mobile: 2,
      tablet: 3,
      desktop: 4,
    );

    // For mobile (2 columns) and tablet/desktop (3-4 columns)
    if (ResponsiveUtils.isMobile(context)) {
      // Build grid with 2 columns for mobile
      return Column(
        children: [
          for (int i = 0; i < cards.length; i += 2)
            Padding(
              padding: EdgeInsets.only(bottom: i + 2 < cards.length ? spacing : 0),
              child: Row(
                children: [
                  Expanded(child: cards[i]),
                  if (i + 1 < cards.length) ...[
                    SizedBox(width: spacing),
                    Expanded(child: cards[i + 1]),
                  ],
                ],
              ),
            ),
        ],
      );
    } else {
      // Build grid with responsive columns for tablet/desktop
      return Column(
        children: [
          for (int i = 0; i < cards.length; i += columns)
            Padding(
              padding: EdgeInsets.only(bottom: i + columns < cards.length ? spacing : 0),
              child: Row(
                children: [
                  for (int j = 0; j < columns && i + j < cards.length; j++) ...[
                    Expanded(child: cards[i + j]),
                    if (j < columns - 1 && i + j + 1 < cards.length)
                      SizedBox(width: spacing),
                  ],
                  // Add empty spaces if the row is not full
                  for (int k = cards.length - i; k < columns; k++) ...[
                    if (k > 0) SizedBox(width: spacing),
                    const Expanded(child: SizedBox()),
                  ],
                ],
              ),
            ),
        ],
      );
    }
  }
}
