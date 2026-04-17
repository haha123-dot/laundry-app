import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wushlaundry/widgets/app_bottom_nav_bar.dart';
import '../constants/app_colors.dart';
import 'home_screen.dart';
import 'my_orders_screen.dart';
import 'services_screen.dart';
import 'offers_screen.dart';
import 'profile_screen.dart';

class MainShellScreen
    extends
        StatefulWidget {
  const MainShellScreen({
    super.key,
  });

  @override
  State<
    MainShellScreen
  >
  createState() => _MainShellScreenState();
}

class _MainShellScreenState
    extends
        State<
          MainShellScreen
        > {
  int _index = 0;

  bool loggedIn = false;
  String? userFirstName;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<
    void
  >
  loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    setState(
      () {
        loggedIn =
            prefs.getBool(
              'isLoggedIn',
            ) ??
            false;
        userFirstName = prefs.getString(
          'userName',
        );
      },
    );
  }

  // ================= NAVIGATION =================
  void _openNotifications() {
    Navigator.pushNamed(
      context,
      '/notifications',
    );
  }

  void _openServices() {
    Navigator.pushNamed(
      context,
      '/services',
    );
  }

  void _openServiceDetail() {
    Navigator.pushNamed(
      context,
      '/service-detail',
    );
  }

  void _openPro() {
    Navigator.pushNamed(
      context,
      '/pro',
    ); // ✅ FIX PRO NAVIGATION
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: AppColors.pageBg,
      body: IndexedStack(
        index: _index,
        children: [
          HomeScreen(
            loggedIn: loggedIn,
            userFirstName: userFirstName,

            onOpenNotifications: _openNotifications,
            onOpenServices: _openServices,
            onOpenServiceDetail: _openServiceDetail,
            onOpenPro: _openPro, // ✅ INI WAJIB ADA
          ),
          const MyOrdersScreen(),
          const ServicesScreen(),
          const OffersScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _index,
        onTap:
            (
              i,
            ) => setState(
              () => _index = i,
            ),
      ),
    );
  }
}
