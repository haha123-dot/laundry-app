import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';

import '../../core/widgets/navigation.dart';
import '../../core/widgets/rounded_white_panel.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.profileNavy,

      // ================= APP BAR =================
      appBar: NavyBackAppBar(
        title: 'Tentang',
        onBack: () => Navigator.pop(context),
      ),

      // ================= BODY =================
      body: RoundedWhitePanel(
        topRadius: AppDimens.radiusXl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimens.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Wush Laundry',
                style: textTheme.titleLarge?.copyWith(fontSize: 20),
              ),
              const SizedBox(height: AppDimens.md),
              Text(
                'Wush Laundry adalah layanan laundry online yang dirancang untuk mempermudah hidup Anda. '
                'Dengan penjemputan dan pengantaran door-to-door, harga transparan, dan proses yang dapat Anda pantau dari aplikasi.',
                style: textTheme.bodyLarge,
              ),
              const SizedBox(height: AppDimens.lg),
              Text(
                'Kami berkomitmen pada kebersihan, kerapian, dan ketepatan waktu agar cucian Anda siap dipakai kembali tanpa repot.',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}