import 'package:flutter/material.dart';
import '../widgets/stat_card.dart';

class ActivityStatisticsScreen extends StatelessWidget {
  const ActivityStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Statistics'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Overview',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      title: 'Total Members',
                      value: '150',
                      icon: Icons.people,
                      iconColor: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: StatCard(
                      title: 'Active Members',
                      value: '142',
                      icon: Icons.person_outline,
                      iconColor: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      title: 'Events This Month',
                      value: '12',
                      icon: Icons.event,
                      iconColor: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: StatCard(
                      title: 'Account Balance',
                      value: '\$25,000',
                      icon: Icons.account_balance_wallet,
                      iconColor: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Engagement',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      title: 'Event Attendance',
                      value: '85%',
                      icon: Icons.check_circle,
                      iconColor: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: StatCard(
                      title: 'Volunteer Hours',
                      value: '320',
                      icon: Icons.volunteer_activism,
                      iconColor: Colors.purple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      title: 'New Members',
                      value: '8',
                      icon: Icons.person_add,
                      iconColor: Colors.teal,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: StatCard(
                      title: 'Meetings Held',
                      value: '4',
                      icon: Icons.groups,
                      iconColor: Colors.indigo,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
