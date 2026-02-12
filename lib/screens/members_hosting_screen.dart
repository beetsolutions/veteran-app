import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/member.dart';
import '../models/hosting_schedule.dart';
import '../data/repositories/hosting_repository.dart';
import '../providers/user_provider.dart';
import '../data/storage/auth_token_storage.dart';
import '../data/api/api_client.dart';

class MembersHostingScreen extends StatefulWidget {
  final HostingRepository? hostingRepository;

  const MembersHostingScreen({
    super.key,
    this.hostingRepository,
  });

  @override
  State<MembersHostingScreen> createState() => _MembersHostingScreenState();
}

class _MembersHostingScreenState extends State<MembersHostingScreen> {
  late final HostingRepository _hostingRepository;
  late final AuthTokenStorage _authTokenStorage;
  HostingSchedule? _currentSchedule;
  HostingSchedule? _nextSchedule;
  bool _isLoading = true;
  String? _errorMessage;
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _hostingRepository = widget.hostingRepository ?? HostingRepository();
    _authTokenStorage = AuthTokenStorage();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // Get the current organization ID from UserProvider
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final organizationId = userProvider.currentOrganization?.id;

      final current = await _hostingRepository.getCurrentSchedule(organizationId: organizationId);
      final next = await _hostingRepository.getNextSchedule(organizationId: organizationId);
      // Load current user ID
      final userId = await _authTokenStorage.getUserId();
      
      final current = await _hostingRepository.getCurrentSchedule();
      final next = await _hostingRepository.getNextSchedule();

      setState(() {
        _currentUserId = userId;
        _currentSchedule = current;
        _nextSchedule = next;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load hosting schedule: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hosting Schedule'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_errorMessage!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadData,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _currentSchedule == null || _nextSchedule == null
                  ? const Center(child: Text('No schedule data available'))
                  : SingleChildScrollView(
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
                                            '${_formatDate(_currentSchedule!.startDate)} - ${_formatDate(_currentSchedule!.endDate)}',
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
                                    '${_currentSchedule!.daysRemaining} days remaining',
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
                                ..._currentSchedule!.hosts.map((host) => _buildHostCard(context, host, true)),
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
                    'Each member contributes £${_currentSchedule!.contributionAmount.toStringAsFixed(0)} per rotation',
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
                          '£${_currentSchedule!.totalCollected.toStringAsFixed(0)}',
                          Colors.green,
                          Icons.check_circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildPaymentSummaryCard(
                          context,
                          'Pending',
                          '£${_currentSchedule!.totalPending.toStringAsFixed(0)}',
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
                              '${_currentSchedule!.paidMembers.length}/${_currentSchedule!.allMembers.length}',
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
                            value: _currentSchedule!.paymentProgress / 100,
                            minHeight: 10,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              theme.colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_currentSchedule!.paymentProgress.toStringAsFixed(0)}% Complete',
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
                      'Paid Members (${_currentSchedule!.paidMembers.length})',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    children: _currentSchedule!.paidMembers.isEmpty
                        ? [
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('No members have paid yet'),
                            )
                          ]
                        : _currentSchedule!.paidMembers
                            .map((member) => _buildPaymentListItem(context, member, true))
                            .toList(),
                  ),

                  const SizedBox(height: 8),

                  // Unpaid Members List
                  ExpansionTile(
                    initiallyExpanded: true,
                    leading: Icon(Icons.pending, color: Colors.orange),
                    title: Text(
                      'Pending Payments (${_currentSchedule!.unpaidMembers.length})',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    children: _currentSchedule!.unpaidMembers.isEmpty
                        ? [
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('All members have paid!'),
                            )
                          ]
                        : _currentSchedule!.unpaidMembers
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
                    '${_formatDate(_nextSchedule!.startDate)} - ${_formatDate(_nextSchedule!.endDate)}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._nextSchedule!.hosts.map((host) => _buildHostCard(context, host, false)),
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
    final isCurrentUser = member.id == _currentUserId;
    final canMarkPayment = isCurrentUser && _isCurrentUserHost;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isPaid ? Colors.green.shade100 : Colors.orange.shade100,
        child: Icon(
          isPaid ? Icons.check : Icons.pending,
          color: isPaid ? Colors.green : Colors.orange,
          size: 20,
        ),
      ),
      title: Text(
        '${member.name}${isCurrentUser ? ' (You)' : ''}',
        style: TextStyle(
          fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(member.location),
      trailing: canMarkPayment
          ? ElevatedButton(
              onPressed: () => _markPayment(!isPaid),
              style: ElevatedButton.styleFrom(
                backgroundColor: isPaid ? Colors.orange : Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              child: Text(
                isPaid ? 'Mark Unpaid' : 'Mark Paid',
                style: const TextStyle(fontSize: 12),
              ),
            )
          : Chip(
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

  /// Check if the current user is a host in the current schedule
  bool get _isCurrentUserHost {
    if (_currentUserId == null || _currentSchedule == null) return false;
    return _currentSchedule!.hosts.any((host) => host.id == _currentUserId);
  }

  /// Mark payment status for the current user
  Future<void> _markPayment(bool isPaid) async {
    if (_currentUserId == null || _currentSchedule == null) return;

    try {
      setState(() {
        _isLoading = true;
      });

      await _hostingRepository.markPayment(
        memberId: _currentUserId!,
        scheduleId: _currentSchedule!.id,
        isPaid: isPaid,
      );

      // Reload data to show updated payment status
      await _loadData();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isPaid ? 'Payment marked as paid' : 'Payment marked as unpaid'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on ApiException catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update payment status: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
