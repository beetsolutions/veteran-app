import 'package:flutter/material.dart';

class MembersHostingScreen extends StatelessWidget {
  const MembersHostingScreen({super.key});

  // Mock data for hosting members
  static const List<Map<String, dynamic>> _hostingMembers = [
    {
      'name': 'John Doe',
      'location': 'New York, NY',
      'capacity': 2,
      'available': true,
    },
    {
      'name': 'Jane Smith',
      'location': 'Los Angeles, CA',
      'capacity': 3,
      'available': true,
    },
    {
      'name': 'Robert Johnson',
      'location': 'Chicago, IL',
      'capacity': 1,
      'available': false,
    },
    {
      'name': 'Mary Williams',
      'location': 'Houston, TX',
      'capacity': 2,
      'available': true,
    },
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Members Hosting'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.blue.shade50,
            child: Row(
              children: [
                const Icon(Icons.home, size: 40, color: Colors.blue),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Members Offering Hosting',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${_hostingMembers.where((m) => m['available'] == true).length} available hosts',
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
              itemCount: _hostingMembers.length,
              itemBuilder: (context, index) {
                final member = _hostingMembers[index];
                final isAvailable = member['available'] as bool;
                
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isAvailable ? Colors.green : Colors.grey,
                      child: const Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      member['name'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(member['location'] as String),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.people,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Capacity: ${member['capacity']}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Chip(
                      label: Text(
                        isAvailable ? 'Available' : 'Unavailable',
                        style: TextStyle(
                          fontSize: 12,
                          color: isAvailable ? Colors.green : Colors.grey,
                        ),
                      ),
                      backgroundColor: isAvailable 
                          ? Colors.green.shade50 
                          : Colors.grey.shade200,
                    ),
                    onTap: () {
                      _showHostingDetails(context, member);
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

  void _showHostingDetails(BuildContext context, Map<String, dynamic> member) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(member['name'] as String),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on, size: 20, color: Colors.blue),
                  const SizedBox(width: 8),
                  Expanded(child: Text(member['location'] as String)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.people, size: 20, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text('Can host ${member['capacity']} people'),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    member['available'] == true 
                        ? Icons.check_circle 
                        : Icons.cancel,
                    size: 20,
                    color: member['available'] == true 
                        ? Colors.green 
                        : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    member['available'] == true 
                        ? 'Currently available' 
                        : 'Currently unavailable',
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            if (member['available'] == true)
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Contact request sent to ${member['name']}'),
                    ),
                  );
                },
                child: const Text('Contact Host'),
              ),
          ],
        );
      },
    );
  }
}
