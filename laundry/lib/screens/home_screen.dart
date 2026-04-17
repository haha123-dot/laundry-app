import 'package:flutter/material.dart';
import 'package:wushlaundry/widgets/active_order_card.dart';
import 'package:wushlaundry/widgets/eta_badge.dart';
import 'package:wushlaundry/widgets/login_modal_sheet.dart';
import 'package:wushlaundry/widgets/offer_image_slider.dart';
import 'package:wushlaundry/widgets/rounded_white_panel.dart';
import 'package:wushlaundry/widgets/section_header_row.dart';
import 'package:wushlaundry/widgets/service_card_compact.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';

class HomeScreen
    extends
        StatelessWidget {
  const HomeScreen({
    super.key,
    this.loggedIn = false,
    this.userFirstName,
    this.onOpenNotifications,
    this.onOpenServices,
    this.onOpenServiceDetail,
    this.onOpenPro,
  });

  final bool loggedIn;
  final String? userFirstName;
  final VoidCallback? onOpenNotifications;
  final VoidCallback? onOpenServices;
  final VoidCallback? onOpenServiceDetail;
  final VoidCallback? onOpenPro;

  void _handleServiceTap(
    BuildContext context,
    VoidCallback? onSuccess,
  ) {
    if (!loggedIn) {
      showLoginModal(
        context,
      );
      return;
    }
    onSuccess?.call();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
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
                AppSpacing.xl,
                AppSpacing.xl,
                AppSpacing.xl,
                8,
              ),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (loggedIn &&
                        userFirstName !=
                            null) ...[
                      Text(
                        'Hi $userFirstName 👋',
                        style: AppTextStyles.screenTitleNavy.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                    ],

                    // ================= LAYANAN =================
                    SectionHeaderRow(
                      title: 'Layanan Laundry Kami',
                      actionLabel: 'Lihat semua',
                      onAction: onOpenServices,
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    SizedBox(
                      height: 128,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const ClampingScrollPhysics(),
                        children: [
                          ServiceCardCompact(
                            title: 'Cuci Regular',
                            priceLabel: 'Rp 20.000/plastik',
                            etaLabel: 'ETA 10 jam',
                            etaType: EtaType.normal,
                            selected: true,
                            onTap: () => _handleServiceTap(
                              context,
                              onOpenServiceDetail,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          ServiceCardCompact(
                            title: 'Cuci Setrika',
                            priceLabel: 'Rp 25.000/plastik',
                            etaLabel: 'ETA 11 jam',
                            etaType: EtaType.fast,
                            onTap: () => _handleServiceTap(
                              context,
                              onOpenServiceDetail,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          ServiceCardCompact(
                            title: 'Cuci Kering',
                            priceLabel: 'Rp 23.000/plastik',
                            etaLabel: 'ETA 12 jam',
                            etaType: EtaType.long, // ⚠️ pastikan ada di enum EtaType
                            onTap: () => _handleServiceTap(
                              context,
                              onOpenServiceDetail,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    // ================= PESANAN =================
                    const SectionHeaderRow(
                      title: 'Pesanan Aktif',
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    ActiveOrderCard(
                      empty: true,
                      statusTitle: '',
                      subtitle: '',
                      currentStep: 0,
                      onTap: null,
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    // ================= PENAWARAN =================
                    SectionHeaderRow(
                      title: 'Penawaran Khusus',
                      actionLabel: 'Lihat semua',
                      onAction: () => Navigator.pushNamed(
                        context,
                        '/offers-full',
                      ),
                    ),

                    OfferImageAutoSlider(
                      onTap:
                          (
                            index,
                          ) {
                            if (index ==
                                0) {
                              onOpenPro?.call();
                            } else {
                              Navigator.pushNamed(
                                context,
                                '/offers-full',
                              );
                            }
                          },
                    ),

                    const SizedBox(
                      height: 24,
                    ),
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

/// ================= HEADER =================
class HomeNavyHeaderBlock
    extends
        StatelessWidget {
  const HomeNavyHeaderBlock({
    super.key,
    this.onSearch,
    this.onNotification,
  });

  final VoidCallback? onSearch;
  final VoidCallback? onNotification;

  @override
  Widget build(
    BuildContext context,
  ) {
    final top = MediaQuery.of(
      context,
    ).padding.top;

    return Container(
      color: AppColors.headerNavy,
      padding: EdgeInsets.fromLTRB(
        20,
        top +
            15,
        20,
        20,
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/logo_white.png',
            height: 100,
          ),
          const Spacer(),
          IconButton(
            onPressed: onSearch,
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: onNotification,
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
