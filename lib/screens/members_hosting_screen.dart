import 'package:flutter/material.dart';
import '../models/member.dart';
import '../models/hosting_schedule.dart';

class MembersHostingScreen extends StatelessWidget {
  const MembersHostingScreen({super.key});

  // Mock data for members
  static final List<Member> _allMembers = [
    const Member(id: '1', name: 'John Doe', location: 'New York, NY', isPaid: true),
    const Member(id: '2', name: 'Jane Smith', location: 'Los Angeles, CA', isPaid: true),
    const Member(id: '3', name: 'Robert Johnson', location: 'Chicago, IL', isPaid: false),
    const Member(id: '4', name: 'Mary Williams', location: 'Houston, TX', isPaid: true),
    const Member(id: '5', name: 'James Brown', location: 'Phoenix, AZ', isPaid: false),
    const Member(id: '6', name: 'Patricia Garcia', location: 'Philadelphia, PA', isPaid: true),
    const Member(id: '7', name: 'Michael Davis', location: 'San Antonio, TX', isPaid: false),
    const Member(id: '8', name: 'Linda Martinez', location: 'San Diego, CA', isPaid: true),
  ];

  // Calculate the current hosting schedule
  static HostingSchedule _getCurrentSchedule() {
    final now = DateTime.now();
    // Calculate the start of the current 2-week period
    // For simplicity, using a fixed reference date
    final referenceDate = DateTime(2024, 1, 1);
    final daysSinceReference = now.difference(referenceDate).inDays;
    final periodNumber = (daysSinceReference / 14).floor();
    final startDate = referenceDate.add(Duration(days: periodNumber * 14));
    final endDate = startDate.add(const Duration(days: 14));

    // Select 3 hosts for this period (rotate based on period number)
    final hostIndices = [
      (periodNumber * 3) % _allMembers.length,
      (periodNumber * 3 + 1) % _allMembers.length,
      (periodNumber * 3 + 2) % _allMembers.length,
    ];
    final hosts = hostIndices.map((i) => _allMembers[i]).toList();

    return HostingSchedule(
      id: 'schedule_$periodNumber',
      startDate: startDate,
      endDate: endDate,
      hosts: hosts,
      allMembers: _allMembers,
    );
  }

  // Get the next hosting schedule
  static HostingSchedule _getNextSchedule() {
    final current = _getCurrentSchedule();
    final nextStartDate = current.endDate;
    final nextEndDate = nextStartDate.add(const Duration(days: 14));

    final now = DateTime.now();
    final referenceDate = DateTime(2024, 1, 1);
    final daysSinceReference = nextStartDate.difference(referenceDate).inDays;
    final periodNumber = (daysSinceReference / 14).floor();

    final hostIndices = [
      (periodNumber * 3) % _allMembers.length,
      (periodNumber * 3 + 1) % _allMembers.length,
      (periodNumber * 3 + 2) % _allMembers.length,
    ];
    final hosts = hostIndices.map((i) => _allMembers[i]).toList();

    return HostingSchedule(
      id: 'schedule_$periodNumber',
      startDate: nextStartDate,
      endDate: nextEndDate,
      hosts: hosts,
      allMembers: _allMembers,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentSchedule = _getCurrentSchedule();
    final nextSchedule = _getNextSchedule();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hosting Schedule'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Rotation Header
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 32,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Current Hosting Rotation',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${_formatDate(currentSchedule.startDate)} - ${_formatDate(currentSchedule.endDate)}',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${currentSchedule.daysRemaining} days remaining',
                      style: TextStyle(
                        color: theme.colorScheme.onSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Current Hosts Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Hosts (3 Members)',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'These members are hosting for this 2-week period',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...currentSchedule.hosts.map((host) => _buildHostCard(context, host, true)),
                ],
              ),
            ),

            const Divider(height: 32, thickness: 2),

            // Payment Tracking Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_balance_wallet, color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        'Payment Tracking',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Each member contributes £${currentSchedule.contributionAmount.toStringAsFixed(0)} per rotation',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Payment Summary Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildPaymentSummaryCard(
                          context,
                          'Collected',
                          '£${currentSchedule.totalCollected.toStringAsFixed(0)}',
                          Colors.green,
                          Icons.check_circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildPaymentSummaryCard(
                          context,
                          'Pending',
                          '£${currentSchedule.totalPending.toStringAsFixed(0)}',
                          Colors.orange,
                          Icons.pending,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Payment Progress Bar
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Payment Progress',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${currentSchedule.paidMembers.length}/${currentSchedule.allMembers.length}',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: currentSchedule.paymentProgress / 100,
                            minHeight: 10,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              theme.colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${currentSchedule.paymentProgress.toStringAsFixed(0)}% Complete',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Paid Members List
                  ExpansionTile(
                    initiallyExpanded: false,
                    leading: Icon(Icons.check_circle, color: Colors.green),
                    title: Text(
                      'Paid Members (${currentSchedule.paidMembers.length})',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    children: currentSchedule.paidMembers.isEmpty
                        ? [
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('No members have paid yet'),
                            )
                          ]
                        : currentSchedule.paidMembers
                            .map((member) => _buildPaymentListItem(context, member, true))
                            .toList(),
                  ),

                  const SizedBox(height: 8),

                  // Unpaid Members List
                  ExpansionTile(
                    initiallyExpanded: true,
                    leading: Icon(Icons.pending, color: Colors.orange),
                    title: Text(
                      'Pending Payments (${currentSchedule.unpaidMembers.length})',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    children: currentSchedule.unpaidMembers.isEmpty
                        ? [
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('All members have paid!'),
                            )
                          ]
                        : currentSchedule.unpaidMembers
                            .map((member) => _buildPaymentListItem(context, member, false))
                            .toList(),
                  ),
                ],
              ),
            ),

            const Divider(height: 32, thickness: 2),

            // Next Rotation Preview
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule, color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        'Next Rotation',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_formatDate(nextSchedule.startDate)} - ${_formatDate(nextSchedule.endDate)}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...nextSchedule.hosts.map((host) => _buildHostCard(context, host, false)),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHostCard(BuildContext context, Member host, bool isCurrent) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isCurrent ? theme.colorScheme.primary : Colors.grey[400],
          child: Icon(
            Icons.home,
            color: Colors.white,
          ),
        ),
        title: Text(
          host.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Expanded(child: Text(host.location)),
          ],
        ),
        trailing: isCurrent
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green),
                ),
                child: const Text(
                  'Hosting',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildPaymentSummaryCard(
    BuildContext context,
    String label,
    String amount,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentListItem(BuildContext context, Member member, bool isPaid) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isPaid ? Colors.green.shade100 : Colors.orange.shade100,
        child: Icon(
          isPaid ? Icons.check : Icons.pending,
          color: isPaid ? Colors.green : Colors.orange,
          size: 20,
        ),
      ),
      title: Text(member.name),
      subtitle: Text(member.location),
      trailing: Chip(
        label: Text(
          isPaid ? 'Paid' : 'Pending',
          style: TextStyle(
            fontSize: 12,
            color: isPaid ? Colors.green : Colors.orange,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: isPaid ? Colors.green.shade50 : Colors.orange.shade50,
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
