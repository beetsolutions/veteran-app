import 'package:flutter/material.dart';
import '../../models/official.dart';
import '../../models/news_item.dart';
import '../../models/user.dart';
import '../../models/organization.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/official_card.dart';
import '../../widgets/news_card.dart';
import '../../widgets/section_header.dart';
import '../details/all_officials_screen.dart';
import '../details/all_news_screen.dart';
import '../../data/repositories/officials_repository.dart';
import '../../data/repositories/news_repository.dart';
import '../../data/api/api_client.dart';
import '../../data/api/auth_api.dart';

class HomeTab extends StatefulWidget {
  final OfficialsRepository? officialsRepository;
  final NewsRepository? newsRepository;
  final User? currentUser;
  final Function(User)? onUserUpdated;

  const HomeTab({
    super.key,
    this.officialsRepository,
    this.newsRepository,
    this.currentUser,
    this.onUserUpdated,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final OfficialsRepository _officialsRepository;
  late final NewsRepository _newsRepository;
  late final AuthApi _authApi;
  
  List<Official> _allOfficials = [];
  List<NewsItem> _allNews = [];
  bool _isLoading = true;
  String? _errorMessage;

  // Sample data - in a real app, this would come from a backend/state management
  static const int _totalMembers = 150; // Total organization members

  @override
  void initState() {
    super.initState();
    _officialsRepository = widget.officialsRepository ?? OfficialsRepository();
    _newsRepository = widget.newsRepository ?? NewsRepository();
    _authApi = AuthApi(ApiClient());
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final officials = await _officialsRepository.getOfficials();
      final news = await _newsRepository.getNews();

      setState(() {
        _allOfficials = officials;
        _allNews = news;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load data: $e';
        _isLoading = false;
      });
    }
  }

  void _showOrganizationSwitcher() {
    if (widget.currentUser == null || widget.currentUser!.organizations.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No organizations available'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Switch Organization'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.currentUser!.organizations.map((org) {
              final isCurrent = org.id == widget.currentUser!.currentOrganizationId;
              return ListTile(
                leading: Icon(
                  Icons.business,
                  color: isCurrent ? Colors.blue : Colors.grey,
                ),
                title: Text(
                  org.name,
                  style: TextStyle(
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                    color: isCurrent ? Colors.blue : null,
                  ),
                ),
                subtitle: Text(org.location),
                trailing: isCurrent
                    ? const Icon(Icons.check_circle, color: Colors.blue)
                    : null,
                onTap: isCurrent
                    ? null
                    : () => _switchOrganization(org),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _switchOrganization(Organization organization) async {
    // Close the dialog safely
    if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      // Call API to switch organization
      await _authApi.switchOrganization(organization.id);

      // Update the user with new organization
      final updatedUser = widget.currentUser!.copyWith(
        currentOrganizationId: organization.id,
      );

      // Notify parent widget
      widget.onUserUpdated?.call(updatedUser);

      // Close loading dialog safely
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
        
      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Switched to ${organization.name}'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // Close loading dialog safely
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
        
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to switch organization: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Take only the first 4 officials for the home screen
    final displayedOfficials = _allOfficials.take(4).toList();
    // Take only the first 3 news items for the home screen
    final displayedNews = _allNews.take(3).toList();

    // Check if user has multiple organizations
    final hasMultipleOrgs = widget.currentUser != null && 
                             widget.currentUser!.organizations.length > 1;

    // Get current organization name for title
    final currentOrgName = widget.currentUser?.currentOrganization?.name ?? 'Home';

    return Scaffold(
      appBar: AppBar(
        title: Text(currentOrgName),
        automaticallyImplyLeading: false,
        actions: hasMultipleOrgs
            ? [
                IconButton(
                  icon: const Icon(Icons.swap_horiz),
                  tooltip: 'Switch Organization',
                  onPressed: _showOrganizationSwitcher,
                ),
              ]
            : null,
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
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      // Statistics Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: StatCard(
                                title: 'Total Members',
                                value: '$_totalMembers',
                                icon: Icons.people,
                                iconColor: Colors.blue,
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
                      ),
                      const SizedBox(height: 24),
                      
                      // Officials Section
                      SectionHeader(
                        title: 'Officials',
                        onShowAllPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllOfficialsScreen(
                                officials: _allOfficials,
                              ),
                            ),
                          );
                        },
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: displayedOfficials.length,
                        itemBuilder: (context, index) {
                          return OfficialCard(
                            official: displayedOfficials[index],
                            onTap: () {
                              // Handle official details navigation
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      
                      // News Section
                      SectionHeader(
                        title: 'Latest News',
                        onShowAllPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllNewsScreen(
                                newsItems: _allNews,
                              ),
                            ),
                          );
                        },
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: displayedNews.length,
                        itemBuilder: (context, index) {
                          return NewsCard(
                            newsItem: displayedNews[index],
                            onTap: () {
                              // Handle news details navigation
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
    );
  }
}
