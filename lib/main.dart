import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants/app_theme.dart';

// ================= FEATURES =================
import 'features/splash/splash_screen.dart';
import 'features/onboarding/onboarding_screen.dart';

import 'features/auth/login_screen.dart';
import 'features/auth/register_screen.dart';
import 'features/auth/pin_entry_screen.dart';

import 'features/shell/main_shell_screen.dart';

import 'features/home/services_screen.dart';
import 'features/services/service_detail_screen.dart';

import 'features/orders/my_orders_screen.dart';
import 'features/orders/pickup_schedule_screen.dart';
import 'features/orders/order_review_screen.dart';
import 'features/orders/payment_method_screen.dart';
import 'features/orders/order_detail_screen.dart';

import 'features/offers/offers_screen.dart';

import 'features/notifications/notifications_screen.dart';

import 'features/profile/settings_screen.dart';
import 'features/profile/about_screen.dart';
import 'features/profile/help_screen.dart';
import 'features/profile/privacy_policy_screen.dart';
import 'features/profile/terms_conditions_screen.dart';

import 'features/subscription/pro_subscription_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ DEV ONLY — reset login setiap run
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  runApp(const WushLaundryApp());
}

class WushLaundryApp extends StatelessWidget {
  const WushLaundryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wush Laundry',
      debugShowCheckedModeBanner: false,

      // ✅ PAKAI THEME UTAMA
      theme: AppTheme.lightTheme,

      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return _page(const SplashScreen(), settings);

          case '/onboarding':
            return _page(const OnboardingScreen(), settings);

          case '/main':
            return _page(const MainShellScreen(), settings);

          case '/login':
            return _page(const LoginScreen(), settings);

          case '/register':
            return _page(const RegisterScreen(), settings);

          case '/services':
            return _page(const ServicesScreen(), settings);

          case '/service-detail':
            return _page(const ServiceDetailScreen(), settings);

          case '/pickup-schedule':
            return _page(const PickupScheduleScreen(), settings);

          case '/order-review':
            return _page(const OrderReviewScreen(), settings);

          case '/payment':
            return _page(const PaymentMethodScreen(), settings);

          case '/pin':
            final wallet = settings.arguments as String? ?? 'DANA';
            return _page(
              PinEntryScreen(walletName: wallet),
              settings,
            );

          case '/notifications':
            return _page(const NotificationsScreen(), settings);

          case '/my-orders':
            return _page(const MyOrdersScreen(), settings);

          case '/offers-full':
            return _page(const OffersScreen(), settings);

          case '/settings':
            return _page(const SettingsScreen(), settings);

          case '/privacy':
            return _page(const PrivacyPolicyScreen(), settings);

          case '/terms':
            return _page(const TermsConditionsScreen(), settings);

          case '/help':
            return _page(const HelpScreen(), settings);

          case '/about':
            return _page(const AboutScreen(), settings);

          case '/pro':
            return _page(const ProSubscriptionScreen(), settings);

          case '/order-detail':
            return _page(const OrderDetailScreen(), settings);
        }

        // ================= FALLBACK =================
        return _page(
          const Scaffold(
            body: Center(
              child: Text('Route not found'),
            ),
          ),
          settings,
        );
      },
    );
  }

  // ✅ Helper supaya rapi
  MaterialPageRoute<void> _page(
    Widget child,
    RouteSettings settings,
  ) {
    return MaterialPageRoute<void>(
      builder: (_) => child,
      settings: settings,
    );
  }
}