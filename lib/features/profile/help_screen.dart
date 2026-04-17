import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';

import '../../core/widgets/navigation.dart';
import '../../core/widgets/rounded_white_panel.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.profileNavy,

      // ================= APP BAR =================
      appBar: NavyBackAppBar(
        title: 'Bantuan',
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
                'Jika Anda mengalami kendala saat menggunakan aplikasi atau layanan kami, '
                'tim customer service siap membantu.',
                style: textTheme.bodyLarge,
              ),
              const SizedBox(height: AppDimens.lg),
              Text(
                'Silakan hubungi kami melalui kanal resmi yang tercantum di aplikasi '
                'atau email dukungan. Sertakan nomor pesanan untuk respon lebih cepat.',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}