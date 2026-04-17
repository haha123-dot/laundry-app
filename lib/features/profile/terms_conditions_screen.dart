import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';

import '../../core/widgets/navigation.dart';
import '../../core/widgets/rounded_white_panel.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.profileNavy,

      // ================= APP BAR =================
      appBar: NavyBackAppBar(
        title: 'Syarat dan Ketentuan',
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
                'Syarat Layanan',
                style: textTheme.titleLarge?.copyWith(fontSize: 18),
              ),
              const SizedBox(height: AppDimens.md),

              _bullet(
                context,
                'Layanan laundry mencakup cuci, kering, setrika, dan pengantaran sesuai paket yang dipilih.',
              ),
              _bullet(
                context,
                'Estimasi waktu dapat berubah tergantung antrean dan kondisi cuaca.',
              ),
              _bullet(
                context,
                'Pelanggan wajib memastikan tidak ada barang berharga di dalam kantong cucian.',
              ),

              const SizedBox(height: AppDimens.lg),

              Text(
                'Kerusakan & Kehilangan',
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: AppDimens.sm),

              _bullet(
                context,
                'Klaim kerusakan dilaporkan maksimal 24 jam setelah pengantaran.',
              ),
              _bullet(
                context,
                'Kompensasi mengikuti kebijakan internal dan bukti yang valid.',
              ),

              const SizedBox(height: AppDimens.lg),

              Text(
                'Pembayaran',
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: AppDimens.sm),

              _bullet(
                context,
                'Pembayaran dilakukan melalui metode yang tersedia di aplikasi.',
              ),
              _bullet(
                context,
                'Promo dan kode diskon tidak dapat digabungkan kecuali dinyatakan lain.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= BULLET ITEM =================
  Widget _bullet(BuildContext context, String text) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: textTheme.bodyMedium,
          ),
          Expanded(
            child: Text(
              text,
              style: textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}