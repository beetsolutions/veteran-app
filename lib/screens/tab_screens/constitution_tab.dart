import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../models/constitution.dart';
import '../../data/repositories/constitution_repository.dart';
import '../../providers/user_provider.dart';

class ConstitutionTab extends StatefulWidget {
  final ConstitutionRepository? constitutionRepository;

  const ConstitutionTab({
    super.key,
    this.constitutionRepository,
  });

  @override
  State<ConstitutionTab> createState() => _ConstitutionTabState();
}

class _ConstitutionTabState extends State<ConstitutionTab> {
  late final ConstitutionRepository _constitutionRepository;
  Constitution? _constitution;
  bool _isLoading = true;
  String? _errorMessage;
  String? _lastOrganizationId;

  @override
  void initState() {
    super.initState();
    _constitutionRepository = widget.constitutionRepository ?? ConstitutionRepository();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reload data when organization changes
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final currentOrgId = userProvider.currentOrganization?.id;
    
    // Initialize on first call, reload on subsequent org changes
    if (_lastOrganizationId == null) {
      _lastOrganizationId = currentOrgId;
      _loadData();
    } else if (currentOrgId != null && currentOrgId != _lastOrganizationId) {
      _lastOrganizationId = currentOrgId;
      _loadData();
    }
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

      if (organizationId == null) {
        setState(() {
          _errorMessage = 'No organization selected';
          _isLoading = false;
        });
        return;
      }

      final constitution = await _constitutionRepository.getConstitution(organizationId);

      setState(() {
        _constitution = constitution;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load constitution: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Constitution'),
          automaticallyImplyLeading: false,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null || _constitution == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Constitution'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_errorMessage ?? 'Failed to load constitution'),
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Constitution'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _constitution!.organizationName,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24),
            ..._constitution!.articles.map((article) => _buildArticle(
              context,
              article.title,
              article.sections,
            )),
            const SizedBox(height: 24),
            Card(
              elevation: 2,
              color: Colors.deepPurple.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.deepPurple),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'This constitution was adopted and ratified by the membership.',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Adopted: ${_constitution!.adoptedDate}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      'Last Amended: ${_constitution!.lastAmended}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  static Widget _buildArticle(
      BuildContext context, String title, List<String> sections) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.share, color: Colors.deepPurple),
              tooltip: 'Share Article',
              onPressed: () {
                // Prepare share content
                final String shareContent = '$title\n\n${sections.join('\n\n')}';
                Share.share(
                  shareContent,
                  subject: title,
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...sections.map((section) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
              child: Text(
                section,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            )),
        const SizedBox(height: 20),
      ],
    );
  }
}
