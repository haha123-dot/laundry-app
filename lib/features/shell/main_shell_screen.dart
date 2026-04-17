import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/navigation.dart';
import '../home/home_screen.dart';
import '../home/services_screen.dart';
import '../offers/offers_screen.dart';
import '../orders/my_orders_screen.dart';
import '../profile/profile_screen.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;

  // contoh state login sederhana
  bool loggedIn = false;
  String? userFirstName;

  void _goToTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBg,

      /// ✅ SEMUA TAB HIDUP DI SINI
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            loggedIn: loggedIn,
            userFirstName: userFirstName,
            onOpenServices: () => _goToTab(2),
            onOpenOffers: () => _goToTab(3), // ✅ INI PENTING
          ),
          const MyOrdersScreen(),
          const ServicesScreen(),
          const OffersScreen(), // ✅ Offers SEBAGAI TAB
          const ProfileScreen(),
        ],
      ),

      /// ✅ SATU-SATUNYA BOTTOM NAV
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _goToTab,
      ),
    );
  }
}