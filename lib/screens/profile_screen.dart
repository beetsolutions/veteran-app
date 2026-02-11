import 'package:flutter/material.dart';
import '../widgets/responsive_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit profile screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Edit profile feature coming soon'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          mobilePadding: EdgeInsets.zero,
          tabletPadding: EdgeInsets.zero,
          desktopPadding: EdgeInsets.zero,
          child: Column(
            children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32.0),
              color: Colors.blue.shade50,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.blue,
                    child: const Text(
                      'JD',
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Member',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            ResponsiveContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contact Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    icon: Icons.email,
                    title: 'Email',
                    value: 'john.doe@example.com',
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    icon: Icons.phone,
                    title: 'Phone',
                    value: '+1 (555) 123-4567',
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Military Service',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    icon: Icons.military_tech,
                    title: 'Service Branch',
                    value: 'United States Army',
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    icon: Icons.calendar_today,
                    title: 'Years of Service',
                    value: '2010 - 2020',
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Membership',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    icon: Icons.info,
                    title: 'Status',
                    value: 'Active Member',
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    icon: Icons.event,
                    title: 'Member Since',
                    value: 'January 2021',
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 32, color: Colors.blue),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
