import 'package:flutter/material.dart';
import '../models/member.dart';

class MemberDetailScreen extends StatelessWidget {
  final String name;
  final String role;
  final String service;
  final MemberStatus status;

  const MemberDetailScreen({
    super.key,
    required this.name,
    required this.role,
    required this.service,
    this.status = MemberStatus.active,
  });

  String _getStatusText() {
    switch (status) {
      case MemberStatus.active:
        return 'Active Member';
      case MemberStatus.suspended:
        return 'Suspended';
      case MemberStatus.dismissed:
        return 'Dismissed';
    }
  }

  Color _getStatusColor() {
    switch (status) {
      case MemberStatus.active:
        return Colors.green.shade700;
      case MemberStatus.suspended:
        return Colors.orange.shade800;
      case MemberStatus.dismissed:
        return Colors.red.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32.0),
              color: Colors.deepPurple.shade50,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.deepPurple,
                    child: Text(
                      name.trim().isNotEmpty ? name.trim()[0].toUpperCase() : '?',
                      style: const TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    role,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(
                    icon: Icons.military_tech,
                    title: 'Service Branch',
                    value: service,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    icon: Icons.work,
                    title: 'Role',
                    value: role,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    icon: Icons.info,
                    title: 'Status',
                    value: _getStatusText(),
                    color: _getStatusColor(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    Color? color,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 32, color: color ?? Colors.deepPurple),
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
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
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
