import 'package:flutter/material.dart';
import '../models/official.dart';

class OfficialCard extends StatelessWidget {
  final Official official;
  final VoidCallback? onTap;

  const OfficialCard({
    super.key,
    required this.official,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            official.name.isNotEmpty ? official.name[0] : '?',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          official.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${official.role} • ${official.service}'),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: onTap,
      ),
    );
  }
}
