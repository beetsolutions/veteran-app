import 'package:flutter/material.dart';

class MembersTab extends StatelessWidget {
  const MembersTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> members = [
      {'name': 'John Doe', 'role': 'President', 'service': 'Army'},
      {'name': 'Jane Smith', 'role': 'Vice President', 'service': 'Navy'},
      {'name': 'Robert Johnson', 'role': 'Secretary', 'service': 'Air Force'},
      {'name': 'Mary Williams', 'role': 'Treasurer', 'service': 'Marines'},
      {'name': 'James Brown', 'role': 'Member', 'service': 'Coast Guard'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
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
                        '${members.length} active members',
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
          Expanded(
            child: ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
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
                      // Navigate to member details
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
