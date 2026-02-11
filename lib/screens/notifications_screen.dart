import 'package:flutter/material.dart';
import '../widgets/responsive_container.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ResponsiveContainer(
        mobilePadding: EdgeInsets.zero,
        tabletPadding: EdgeInsets.zero,
        desktopPadding: EdgeInsets.zero,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
          const Text(
            'Recent Notifications',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildNotificationCard(
            context,
            icon: Icons.event,
            iconColor: Colors.blue,
            title: 'Upcoming Event',
            description: 'Monthly meeting scheduled for this Friday at 6:00 PM',
            time: '2 hours ago',
            isRead: false,
          ),
          _buildNotificationCard(
            context,
            icon: Icons.account_balance_wallet,
            iconColor: Colors.green,
            title: 'Payment Reminder',
            description: 'Your monthly contribution of £20 is due',
            time: '5 hours ago',
            isRead: false,
          ),
          _buildNotificationCard(
            context,
            icon: Icons.people,
            iconColor: Colors.purple,
            title: 'New Member Joined',
            description: 'Welcome Sarah Johnson to our organization!',
            time: '1 day ago',
            isRead: true,
          ),
          _buildNotificationCard(
            context,
            icon: Icons.home_work,
            iconColor: Colors.orange,
            title: 'Hosting Schedule Updated',
            description: 'New hosting rotation has been posted for next period',
            time: '2 days ago',
            isRead: true,
          ),
          _buildNotificationCard(
            context,
            icon: Icons.volunteer_activism,
            iconColor: Colors.red,
            title: 'Volunteer Opportunity',
            description: 'Help needed for community outreach event',
            time: '3 days ago',
            isRead: true,
          ),
          _buildNotificationCard(
            context,
            icon: Icons.article,
            iconColor: Colors.teal,
            title: 'Constitution Updated',
            description: 'New amendments have been added to the constitution',
            time: '1 week ago',
            isRead: true,
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required String time,
    required bool isRead,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isRead ? 1 : 2,
      color: isRead ? null : Colors.blue.shade50,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.1),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(description),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        isThreeLine: true,
        trailing: isRead
            ? null
            : Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
      ),
    );
  }
}
