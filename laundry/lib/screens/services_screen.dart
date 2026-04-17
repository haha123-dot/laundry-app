import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import '../widgets/eta_badge.dart';
import '../widgets/navy_app_bar.dart';
import '../widgets/search_field_rounded.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.headerNavy,

      // ================= APP BAR =================
      appBar: const NavyCenterTitleAppBar(
        title: 'Layanan',
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

      // ================= BODY =================
      body: Container(
        width: double.infinity,

        // ✅ putih turun sedikit dari appbar
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
            0, // ❌ jangan padding manual di sini
          ),

          // ✅ INI KUNCI SUPAYA PUTIH NYENTUH NAVBAR
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: kBottomNavigationBarHeight,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchFieldRounded(),

                const SizedBox(height: AppSpacing.lg),
                Text('Layanan Lainnya', style: AppTextStyles.sectionTitle),
                const SizedBox(height: AppSpacing.md),

                // ================= GRID =================
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.82,
                  children: [
                    _gridCard(
                      context,
                      title: 'Cuci Regular',
                      price: 'Rp 20.000 / Plastik',
                      eta: 'ETA 10 jam',
                      etaType: EtaType.normal,
                    ),
                    _gridCard(
                      context,
                      title: 'Cuci Setrika',
                      price: 'Rp 28.000 / Plastik',
                      eta: 'ETA 11 jam',
                      etaType: EtaType.fast,
                    ),
                    _gridCard(
                      context,
                      title: 'Cuci Kering',
                      price: 'Rp 23.000 / Plastik',
                      eta: 'ETA 12 jam',
                      etaType: EtaType.long,
                    ),
                    _gridCard(
                      context,
                      title: 'Paket Layanan',
                      price: 'Rp 48.000 / Plastik',
                      eta: 'Express',
                      etaType: EtaType.express,
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.xl),

                // ================= BEDCOVER =================
                _bedcoverCard(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= GRID CARD =================
  Widget _gridCard(
    BuildContext context, {
    required String title,
    required String price,
    required String eta,
    required EtaType etaType,
  }) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/service-detail'),
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.serviceCardTint,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.local_laundry_service,
                        size: 42,
                        color: AppColors.actionBlue,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: EtaBadge(label: eta, type: etaType),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.sectionTitle.copyWith(fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      price,
                      style: AppTextStyles.caption.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= BEDCOVER CARD =================
  Widget _bedcoverCard(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/service-detail'),
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Row(
            children: [
              Container(
                width: 76,
                height: 68,
                decoration: BoxDecoration(
                  color: AppColors.serviceCardTint,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.local_laundry_service,
                  size: 34,
                  color: AppColors.actionBlue,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cuci Bedcover / Selimut / Sprei',
                      style: AppTextStyles.sectionTitle.copyWith(fontSize: 13),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Mulai Rp45.000',
                      style: AppTextStyles.bodyMuted.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              const EtaBadge(
                label: 'ETA 24 jam',
                type: EtaType.long,
              ),
            ],
          ),
        ),
      ),
    );
  }
}