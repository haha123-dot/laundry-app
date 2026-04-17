import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';

import '../../core/widgets/navigation.dart';
import '../../core/widgets/rounded_white_panel.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.profileNavy,

      // ================= APP BAR =================
      appBar: NavyBackAppBar(
        title: 'Kebijakan Privasi',
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
                'Kebijakan Privasi',
                style: textTheme.titleLarge?.copyWith(fontSize: 18),
              ),
              const SizedBox(height: AppDimens.md),
              Text(
                'Kami menghormati privasi Anda. Data pribadi digunakan untuk '
                'memproses pesanan, komunikasi layanan, dan peningkatan pengalaman aplikasi.',
                style: textTheme.bodyMedium,
              ),

              const SizedBox(height: AppDimens.xl),

              Text(
                'Pedoman Pengguna',
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: AppDimens.sm),
              _bullet(
                context,
                'Gunakan layanan sesuai ketentuan yang berlaku.',
              ),
              _bullet(
                context,
                'Pastikan informasi alamat dan kontak akurat.',
              ),
              _bullet(
                context,
                'Segala bentuk penyalahgunaan dapat mengakibatkan penangguhan akun.',
              ),

              const SizedBox(height: AppDimens.xl),

              Text(
                'Penggunaan Data',
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: AppDimens.sm),
              _bullet(
                context,
                'Data lokasi dipakai untuk penjemputan dan pengantaran.',
              ),
              _bullet(
                context,
                'Riwayat pesanan disimpan untuk keperluan garansi layanan.',
              ),

              TextButton(
                onPressed: () {},
                child: Text(
                  'Pelajari lebih lanjut tentang cookie',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.linkBlue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= BULLET =================
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