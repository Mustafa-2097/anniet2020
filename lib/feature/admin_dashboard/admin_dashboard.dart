import 'package:anniet2020/feature/admin_dashboard/payments/views/payment_list_page.dart';
import 'package:anniet2020/feature/admin_dashboard/settings/views/settings_page.dart';
import 'package:anniet2020/feature/admin_dashboard/users/views/users_page.dart';
import 'package:anniet2020/feature/admin_dashboard/widgets/admin_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'contact/views/contact_page.dart';
import 'dashboard/views/dashboard_page.dart';

class AdminDashboard extends StatefulWidget {
  final int initialIndex;
  const AdminDashboard({super.key, this.initialIndex = 0});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  late int _selectedIndex;

  final List<Widget> _screens = [
    DashboardPage(),
    UsersPage(),
    PaymentListPage(),
    ContactPage(),
    SettingsPage(),
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
      bottomNavigationBar: AdminBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
