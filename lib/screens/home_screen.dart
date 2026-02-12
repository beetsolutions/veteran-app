import 'package:flutter/material.dart';
import 'tab_screens/home_tab.dart';
import 'tab_screens/constitution_tab.dart';
import 'tab_screens/members_tab.dart';
import 'tab_screens/minutes_tab.dart';
import 'tab_screens/more_tab.dart';
import '../models/user.dart';

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
  final List<Widget> _tabs = [
    const HomeTab(),
    const ConstitutionTab(),
    const MembersTab(),
    const MinutesTab(),
    const MoreTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> _tabs = [
      HomeTab(currentUser: _currentUser, onUserUpdated: _updateUser),
      const ConstitutionTab(),
      const MembersTab(),
      const MoreTab(),
    ];

    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Constitution',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Members',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: 'Minutes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
