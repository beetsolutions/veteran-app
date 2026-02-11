import 'package:flutter/material.dart';
import '../../models/official.dart';
import '../../widgets/official_card.dart';

class AllOfficialsScreen extends StatelessWidget {
  final List<Official> officials;

  const AllOfficialsScreen({
    super.key,
    required this.officials,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Officials'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: officials.length,
        itemBuilder: (context, index) {
          return OfficialCard(
            official: officials[index],
            onTap: () {
              // Handle official details navigation
            },
          );
        },
      ),
    );
  }
}
