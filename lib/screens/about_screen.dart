import 'package:flutter/material.dart';
import '../widgets/responsive_container.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Icon and Name
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.military_tech,
                      size: 100,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'VeteranApp',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // Description
              const Text(
                'About VeteranApp',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'VeteranApp is a comprehensive application designed to serve veteran organizations. '
                'Our mission is to provide a centralized platform for veterans to stay connected, '
                'informed, and engaged with their community.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              
              // Features Section
              const Text(
                'Features',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildFeatureItem(
                icon: Icons.dashboard,
                title: 'Dashboard',
                description: 'Access statistics, news, and officials at a glance',
              ),
              _buildFeatureItem(
                icon: Icons.people,
                title: 'Member Directory',
                description: 'Connect with fellow veterans in your organization',
              ),
              _buildFeatureItem(
                icon: Icons.home_work,
                title: 'Hosting Schedule',
                description: 'Track and manage member hosting rotations',
              ),
              _buildFeatureItem(
                icon: Icons.bar_chart,
                title: 'Activity Statistics',
                description: 'Monitor engagement and participation metrics',
              ),
              _buildFeatureItem(
                icon: Icons.description,
                title: 'Constitution',
                description: 'Access organization rules and guidelines',
              ),
              const SizedBox(height: 24),
              
              // Contact Section
              const Text(
                'Contact & Support',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildInfoCard(
                icon: Icons.email,
                title: 'Email',
                content: 'support@veteranapp.com',
              ),
              _buildInfoCard(
                icon: Icons.web,
                title: 'Website',
                content: 'www.veteranapp.com',
              ),
              const SizedBox(height: 24),
              
              // Legal Section
              const Text(
                'Legal',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildLegalItem('Privacy Policy'),
              _buildLegalItem('Terms of Service'),
              _buildLegalItem('Open Source Licenses'),
              const SizedBox(height: 24),
              
              // Copyright
              Center(
                child: Text(
                  '© 2026 VeteranApp. All rights reserved.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        subtitle: Text(content),
      ),
    );
  }

  Widget _buildLegalItem(String title) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Navigate to respective legal page
        },
      ),
    );
  }
}
