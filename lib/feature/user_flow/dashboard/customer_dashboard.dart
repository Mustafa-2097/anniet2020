import 'package:anniet2020/feature/user_flow/about/views/about_us_page.dart';
import 'package:anniet2020/feature/user_flow/dashboard/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import '../courses/views/courses_page.dart';
import '../home_page/views/home_page.dart';
import '../profile/views/profile_page.dart';

class CustomerDashboard extends StatefulWidget {
  final int initialIndex;
  const CustomerDashboard({super.key, this.initialIndex = 0});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  late int _selectedIndex;

  final List<Widget> _screens = [
    HomePage(),
    CoursesPage(),
    AboutUsPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // set initial tab
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
