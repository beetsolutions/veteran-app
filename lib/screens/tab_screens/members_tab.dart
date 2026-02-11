import 'package:flutter/material.dart';
import '../member_detail_screen.dart';
import '../../models/member.dart';

class MembersTab extends StatelessWidget {
  const MembersTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> members = [
      {'name': 'John Doe', 'role': 'President', 'service': 'Army', 'status': MemberStatus.active},
      {'name': 'Jane Smith', 'role': 'Vice President', 'service': 'Navy', 'status': MemberStatus.active},
      {'name': 'Robert Johnson', 'role': 'Secretary', 'service': 'Air Force', 'status': MemberStatus.active},
      {'name': 'Mary Williams', 'role': 'Treasurer', 'service': 'Marines', 'status': MemberStatus.active},
      {'name': 'James Brown', 'role': 'Member', 'service': 'Coast Guard', 'status': MemberStatus.active},
      {'name': 'Patricia Garcia', 'role': 'Member', 'service': 'Army', 'status': MemberStatus.suspended},
      {'name': 'Michael Davis', 'role': 'Member', 'service': 'Navy', 'status': MemberStatus.suspended},
      {'name': 'Thomas Wilson', 'role': 'Member', 'service': 'Air Force', 'status': MemberStatus.dismissed},
      {'name': 'Jennifer Martinez', 'role': 'Member', 'service': 'Marines', 'status': MemberStatus.dismissed},
    ];

    final activeMembers = members.where((m) => m['status'] == MemberStatus.active).toList();
    final suspendedMembers = members.where((m) => m['status'] == MemberStatus.suspended).toList();
    final dismissedMembers = members.where((m) => m['status'] == MemberStatus.dismissed).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.blue.shade50,
            child: Row(
              children: [
                const Icon(Icons.people, size: 40, color: Colors.blue),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Organization Members',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${members.length} total • ${activeMembers.length} active • ${suspendedMembers.length} suspended • ${dismissedMembers.length} dismissed',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (activeMembers.isNotEmpty) ...[
            _buildSectionHeader('Active Members', activeMembers.length, Colors.green),
            ...activeMembers.map((member) => _buildMemberCard(context, member, Colors.green)),
          ],
          if (suspendedMembers.isNotEmpty) ...[
            _buildSectionHeader('Suspended Members', suspendedMembers.length, Colors.orange),
            ...suspendedMembers.map((member) => _buildMemberCard(context, member, Colors.orange)),
          ],
          if (dismissedMembers.isNotEmpty) ...[
            _buildSectionHeader('Dismissed Members', dismissedMembers.length, Colors.red),
            ...dismissedMembers.map((member) => _buildMemberCard(context, member, Colors.red)),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: color.withOpacity(0.1),
      child: Row(
        children: [
          Icon(Icons.label, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard(BuildContext context, Map<String, dynamic> member, Color statusColor) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor,
          child: Text(
            member['name']![0],
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          member['name']!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${member['role']} • ${member['service']}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MemberDetailScreen(
                name: member['name']!,
                role: member['role']!,
                service: member['service']!,
                status: member['status'] as MemberStatus,
              ),
            ),
          );
        },
      ),
    );
  }
}
