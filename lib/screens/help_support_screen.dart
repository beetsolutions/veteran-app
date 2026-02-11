import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Center(
                child: Icon(
                  Icons.help_center,
                  size: 80,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'We\'re Here to Help',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Find answers to common questions or get in touch',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),

              // FAQ Section
              Text(
                'Frequently Asked Questions',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildFAQItem(
                context,
                'How do I update my profile?',
                'Navigate to the More tab and select Profile. From there, you can edit your information and save changes.',
              ),
              _buildFAQItem(
                context,
                'How does the hosting rotation work?',
                'Members are assigned in groups of 3 for 2-week hosting periods. Check the Members Hosting section for current and upcoming schedules.',
              ),
              _buildFAQItem(
                context,
                'How do I make a payment?',
                'Payment information and tracking can be found in the Members Hosting screen. Each member contributes their share per rotation period.',
              ),
              _buildFAQItem(
                context,
                'How do I enable notifications?',
                'Go to Settings in the More tab and configure your notification preferences for events, updates, and announcements.',
              ),
              const SizedBox(height: 32),

              // Contact Section
              Text(
                'Contact Us',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildContactCard(
                context,
                icon: Icons.email,
                title: 'Email Support',
                subtitle: 'support@veteranapp.org',
                onTap: () {
                  // Handle email action
                },
              ),
              _buildContactCard(
                context,
                icon: Icons.phone,
                title: 'Phone Support',
                subtitle: '+1 (555) 123-4567',
                onTap: () {
                  // Handle phone action
                },
              ),
              _buildContactCard(
                context,
                icon: Icons.chat_bubble,
                title: 'Live Chat',
                subtitle: 'Available Mon-Fri, 9AM-5PM EST',
                onTap: () {
                  // Handle chat action
                },
              ),
              const SizedBox(height: 32),

              // Resources Section
              Text(
                'Resources',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildResourceCard(
                context,
                icon: Icons.book,
                title: 'User Guide',
                description: 'Complete guide to using the app',
              ),
              _buildResourceCard(
                context,
                icon: Icons.article,
                title: 'Documentation',
                description: 'Detailed documentation and tutorials',
              ),
              _buildResourceCard(
                context,
                icon: Icons.policy,
                title: 'Privacy Policy',
                description: 'Review our privacy and data policies',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context, String question, String answer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: const Icon(Icons.help_outline, color: Colors.blue),
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: TextStyle(
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: Icon(icon, color: Colors.blue),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Widget _buildResourceCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Icon(icon, color: theme.colorScheme.primary),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Handle resource navigation
        },
      ),
    );
  }
}
