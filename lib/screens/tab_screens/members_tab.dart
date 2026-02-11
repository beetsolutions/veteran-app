import 'package:flutter/material.dart';
import '../member_detail_screen.dart';
import '../../models/member.dart';
import '../../data/repositories/members_repository.dart';
import '../../widgets/responsive_container.dart';

class MembersTab extends StatefulWidget {
  final MembersRepository? membersRepository;

  const MembersTab({
    super.key,
    this.membersRepository,
  });

  @override
  State<MembersTab> createState() => _MembersTabState();
}

class _MembersTabState extends State<MembersTab> {
  late final MembersRepository _membersRepository;
  List<Member> _members = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _membersRepository = widget.membersRepository ?? MembersRepository();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final members = await _membersRepository.getMembers();

      setState(() {
        _members = members;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load members: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Members'),
          automaticallyImplyLeading: false,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Members'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
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
        ),
      );
    }

    final activeMembers = _members.where((m) => m.status == MemberStatus.active).toList();
    final suspendedMembers = _members.where((m) => m.status == MemberStatus.suspended).toList();
    final dismissedMembers = _members.where((m) => m.status == MemberStatus.dismissed).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
        automaticallyImplyLeading: false,
      ),
      body: ResponsiveContainer(
        mobilePadding: EdgeInsets.zero,
        tabletPadding: EdgeInsets.zero,
        desktopPadding: EdgeInsets.zero,
        child: ListView(
          children: [
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

  Widget _buildMemberCard(BuildContext context, Member member, Color statusColor) {
    // Use role and service from member data
    final role = member.role ?? 'Member';
    final service = member.service ?? 'Unknown';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor,
          child: Text(
            member.name[0],
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          member.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('$role • $service'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MemberDetailScreen(
                name: member.name,
                role: role,
                service: service,
                status: member.status,
              ),
            ),
          );
        },
      ),
    );
  }
}
