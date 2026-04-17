import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';

import '../../core/widgets/navigation.dart';
import '../../core/widgets/forms.dart';
import '../../core/widgets/rounded_white_panel.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.headerNavy,

      // ================= APP BAR =================
      appBar: NavyCenterTitleAppBar(
        title: 'Voucher',
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.white,
              size: 26,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),

      // ================= BODY =================
      body: Column(
        children: [
          Expanded(
            child: RoundedWhitePanel(
              topRadius: AppDimens.radiusXl,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppDimens.xl,
                  AppDimens.xl,
                  AppDimens.xl,
                  AppDimens.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SearchFieldRounded(),

                    const SizedBox(height: AppDimens.lg),
                    Text('Tawaran Pengguna Baru', style: textTheme.titleMedium),
                    const SizedBox(height: AppDimens.md),

                    _promoCard(
                      context,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF60E6D2), Color(0xFF5BB2F6)],
                      ),
                      title: 'Diskon 15% untuk Pengguna Baru',
                      subtitle: 'Gunakan kode: SSSd789',
                      badgeText: '15%\nDiskon',
                    ),

                    const SizedBox(height: AppDimens.xl),
                    Text('Penawaran Khusus', style: textTheme.titleMedium),
                    const SizedBox(height: AppDimens.md),

                    _promoCard(
                      context,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF5BB2F6), Color(0xFF3ECED0)],
                      ),
                      title: 'Payday Sale Diskon Rp10.000',
                      subtitle: 'Minimal transaksi Rp45.000',
                      badgeText: 'Payday\nSale',
                    ),

                    const SizedBox(height: AppDimens.md),

                    _promoCard(
                      context,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3ECED0), Color(0xFF8CD6FF)],
                      ),
                      title: 'Cuci Bedcover Diskon 10%',
                      subtitle: 'Selama bulan Juli',
                      leadingIcon: Icons.local_laundry_service,
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= PROMO CARD =================
  Widget _promoCard(
    BuildContext context, {
    required LinearGradient gradient,
    required String title,
    required String subtitle,
    String? badgeText,
    IconData? leadingIcon,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppDimens.lg),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.deepNavy,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.deepNavy,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 38,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.deepNavy,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Gunakan Sekarang'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          if (badgeText != null)
            _promoBadge(context, badgeText)
          else if (leadingIcon != null)
            Icon(leadingIcon, size: 44, color: AppColors.deepNavy),
        ],
      ),
    );
  }

  Widget _promoBadge(BuildContext context, String text) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 64,
      height: 64,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: textTheme.titleMedium?.copyWith(fontSize: 12),
      ),
    );
  }
}
