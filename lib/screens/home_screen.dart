import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tab_screens/home_tab.dart';
import 'tab_screens/constitution_tab.dart';
import 'tab_screens/members_tab.dart';
import 'tab_screens/minutes_tab.dart';
import 'tab_screens/more_tab.dart';
import '../models/user.dart';
import '../providers/feature_flags_provider.dart';

class HomeScreen extends StatefulWidget {
  final User? initialUser;

  const HomeScreen({super.key, this.initialUser});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.initialUser;
  }

  void _updateUser(User user) {
    setState(() {
      _currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    final featureFlags = context.watch<FeatureFlagsProvider>().featureFlags;

    // Build tabs list based on feature flags
    final List<Widget> tabs = [];
    final List<BottomNavigationBarItem> navItems = [];

    // Home tab (always visible)
    tabs.add(HomeTab(currentUser: _currentUser, onUserUpdated: _updateUser));
    navItems.add(const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ));

    // Constitution tab (conditional)
    if (featureFlags.showConstitutionTab) {
      tabs.add(const ConstitutionTab());
      navItems.add(const BottomNavigationBarItem(
        icon: Icon(Icons.article),
        label: 'Constitution',
      ));
    }

    // Members tab (always visible)
    tabs.add(const MembersTab());
    navItems.add(const BottomNavigationBarItem(
      icon: Icon(Icons.people),
      label: 'Members',
    ));

    // Minutes tab (conditional)
    if (featureFlags.showMinutesTab) {
      tabs.add(const MinutesTab());
      navItems.add(const BottomNavigationBarItem(
        icon: Icon(Icons.event_note),
        label: 'Minutes',
      ));
    }

    // More tab (always visible)
    tabs.add(const MoreTab());
    navItems.add(const BottomNavigationBarItem(
      icon: Icon(Icons.more_horiz),
      label: 'More',
    ));

    // Ensure current index is within bounds
    final safeIndex = _currentIndex < tabs.length ? _currentIndex : 0;

    return Scaffold(
      body: tabs[safeIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: safeIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: navItems,
      ),
    );
  }
}
