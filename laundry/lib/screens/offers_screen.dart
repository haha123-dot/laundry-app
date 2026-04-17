import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import '../widgets/navy_app_bar.dart';
import '../widgets/search_field_rounded.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.headerNavy,
      child: Column(
        children: [
          // ================= APP BAR =================
          const NavyCenterTitleAppBar(
            title: 'Tawaranku',
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ],
          ),

          // ================= WHITE PANEL =================
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 12),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xl,
                  AppSpacing.xl,
                  AppSpacing.xl,
                  AppSpacing.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SearchFieldRounded(),

                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'Tawaran Pengguna Baru',
                      style: AppTextStyles.sectionTitle,
                    ),
                    const SizedBox(height: AppSpacing.md),

                    _promoCard(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF60E6D2), Color(0xFF5BB2F6)],
                      ),
                      title: 'Diskon 15% untuk Pengguna Baru',
                      subtitle: 'gunakan kode: SSSd789',
                      badgeText: '15%\nDiskon',
                    ),

                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      'Penawaran Khusus',
                      style: AppTextStyles.sectionTitle,
                    ),
                    const SizedBox(height: AppSpacing.md),

                    _promoCard(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF5BB2F6), Color(0xFF3ECED0)],
                      ),
                      title: 'Payday Sale Diskon Rp10.000',
                      subtitle: 'minimal transaksi Rp45.000',
                      badgeText: 'Payday\nSale',
                    ),

                    const SizedBox(height: AppSpacing.md),

                    _promoCard(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3ECED0), Color(0xFF8CD6FF)],
                      ),
                      title: 'Cuci Bedcover Diskon 10%',
                      subtitle: 'selama bulan Juli',
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

  Widget _promoCard({
    required LinearGradient gradient,
    required String title,
    required String subtitle,
    String? badgeText,
    IconData? leadingIcon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
                  style: AppTextStyles.sectionTitle.copyWith(
                    color: AppColors.deepNavy,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: AppTextStyles.bodyMuted.copyWith(
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
            _promoBadge(badgeText)
          else if (leadingIcon != null)
            Icon(
              leadingIcon,
              size: 44,
              color: AppColors.deepNavy,
            ),
        ],
      ),
    );
  }

  Widget _promoBadge(String text) {
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
        style: AppTextStyles.sectionTitle.copyWith(fontSize: 12),
      ),
    );
  }
}