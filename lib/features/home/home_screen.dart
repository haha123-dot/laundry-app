import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';

import '../../core/widgets/cards.dart';
import '../../core/widgets/indicators.dart';
import '../../core/widgets/navigation.dart';
import '../../core/widgets/rounded_white_panel.dart';
import '../../core/widgets/section_header_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    this.loggedIn = false,
    this.userFirstName,
    this.onOpenNotifications,
    this.onOpenServices,
    this.onOpenServiceDetail,
    this.onOpenPro,
    this.onOpenOffers, // ✅ BARU
  });

  final bool loggedIn;
  final String? userFirstName;
  final VoidCallback? onOpenNotifications;
  final VoidCallback? onOpenServices;
  final VoidCallback? onOpenServiceDetail;
  final VoidCallback? onOpenPro;
  final VoidCallback? onOpenOffers; // ✅ BARU

  void _handleServiceTap(BuildContext context, VoidCallback? onSuccess) {
    if (!loggedIn) {
      showLoginModal(context);
      return;
    }
    onSuccess?.call();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ColoredBox(
      color: AppColors.headerNavy,
      child: Column(
        children: [
          HomeNavyHeaderBlock(
            onSearch: onOpenServices,
            onNotification: onOpenNotifications,
          ),

          Expanded(
            child: RoundedWhitePanel(
              topRadius: 40,
              padding: const EdgeInsets.fromLTRB(
                AppDimens.xl,
                AppDimens.xl,
                AppDimens.xl,
                AppDimens.sm,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (loggedIn && userFirstName != null) ...[
                      Text(
                        'Hi $userFirstName 👋',
                        style: textTheme.titleLarge?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: AppDimens.sm),
                    ],

                    // ================= LAYANAN =================
                    const SectionHeaderRow(title: 'Layanan Laundry Kami'),
                    const SizedBox(height: AppDimens.sm),

                    SizedBox(
                      height: 128,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ServiceCardCompact(
                            title: 'Cuci Regular',
                            priceLabel: 'Rp 20.000/plastik',
                            etaLabel: 'ETA 10 jam',
                            etaType: EtaType.normal,
                            selected: true,
                            onTap: () =>
                                _handleServiceTap(context, onOpenServiceDetail),
                          ),
                          const SizedBox(width: AppDimens.sm),
                          ServiceCardCompact(
                            title: 'Cuci Setrika',
                            priceLabel: 'Rp 25.000/plastik',
                            etaLabel: 'ETA 11 jam',
                            etaType: EtaType.fast,
                            onTap: () =>
                                _handleServiceTap(context, onOpenServiceDetail),
                          ),
                          const SizedBox(width: AppDimens.sm),
                          ServiceNextCard(onTap: onOpenServices),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppDimens.xl),

                    // ================= PESANAN =================
                    SectionHeaderRow(
                      title: 'Pesanan Aktif',
                      actionLabel: loggedIn ? 'Lihat semua' : null,
                      onAction: loggedIn ? () => onOpenOffers?.call() : null,
                    ),

                    const ActiveOrderCard(
                      empty: true,
                      statusTitle: 'Belum ada pesanan',
                      subtitle: 'Mulai order untuk melihat status cucian kamu.',
                      currentStep: 0,
                      onTap: null,
                    ),

                    const SizedBox(height: AppDimens.xl),

                    // ================= PENAWARAN =================
                    SectionHeaderRow(
                      title: 'Penawaran Khusus',
                      actionLabel: 'Lihat semua',
                      onAction: onOpenOffers, // ✅ FIX: BUKAN Navigator.push
                    ),

                    OfferImageAutoSlider(
                      onTap: (index) {
                        if (index == 0) {
                          onOpenPro?.call();
                        } else {
                          onOpenOffers?.call(); // ✅ pindah TAB
                        }
                      },
                    ),

                    const SizedBox(height: AppDimens.lg),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeNavyHeaderBlock extends StatelessWidget {
  const HomeNavyHeaderBlock({
    super.key,
    this.onSearch,
    this.onNotification,
  });

  // ✅ PARAMETER SESUAI YANG DIPANGGIL
  final VoidCallback? onSearch;
  final VoidCallback? onNotification;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;

    return Container(
      color: AppColors.headerNavy,
      padding: EdgeInsets.fromLTRB(
        AppDimens.lg,
        topInset + AppDimens.md,
        AppDimens.lg,
        AppDimens.lg,
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/logo_white.png',
            height: 100,
          ),
          const Spacer(),

          // ✅ SEARCH
          _CircleIcon(
            icon: Icons.search,
            onTap: onSearch,
          ),

          const SizedBox(width: AppDimens.sm),

          // ✅ NOTIFICATION
          _CircleIcon(
            icon: Icons.notifications_none_rounded,
            onTap: onNotification,
          ),
        ],
      ),
    );
  }
}
class _CircleIcon extends StatelessWidget {
  const _CircleIcon({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.iconCircle,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.sm),
          child: Icon(icon, size: 20, color: AppColors.headerNavy),
        ),
      ),
    );
  }
}
