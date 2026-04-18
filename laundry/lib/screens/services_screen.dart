import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import '../widgets/eta_badge.dart';
import '../widgets/navy_app_bar.dart';
import '../widgets/login_modal_sheet.dart';

class ServicesScreen
    extends
        StatelessWidget {
  const ServicesScreen({
    super.key,
    this.onOpenNotifications,
    this.loggedIn = false,
  });

  final VoidCallback? onOpenNotifications;
  final bool loggedIn;

  void _handleTap(
    BuildContext context,
    VoidCallback action,
  ) {
    if (!loggedIn) {
      showLoginModal(
        context,
      );
      return;
    }
    action();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: AppColors.headerNavy,

      appBar: NavyCenterTitleAppBar(
        title: 'Layanan',
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: GestureDetector(
              onTap: () => _handleTap(
                context,
                () => onOpenNotifications?.call(),
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
        ],
      ),

      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(
          top: 12,
        ),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              28,
            ),
          ),
        ),

        child: ScrollConfiguration(
          behavior: const _NoOverscrollBehavior(),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.xl,
              AppSpacing.xl,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Layanan Lainnya',
                  style: AppTextStyles.sectionTitle,
                ),
                const SizedBox(
                  height: AppSpacing.md,
                ),

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
                      imagePath: 'assets/images/cuci.jpg',
                    ),
                    _gridCard(
                      context,
                      title: 'Cuci Setrika',
                      price: 'Rp 28.000 / Plastik',
                      eta: 'ETA 11 jam',
                      etaType: EtaType.fast,
                      imagePath: 'assets/images/setrika.jpeg',
                    ),
                    _gridCard(
                      context,
                      title: 'Cuci Kering',
                      price: 'Rp 23.000 / Plastik',
                      eta: 'ETA 12 jam',
                      etaType: EtaType.long,
                      imagePath: 'assets/images/cucikering.jpeg',
                    ),
                    _gridCard(
                      context,
                      title: 'Paket Layanan',
                      price: 'Rp 48.000 / Plastik',
                      eta: 'Express',
                      etaType: EtaType.express,
                      imagePath: 'assets/images/paket.jpg',
                    ),
                    _gridCard(
                      context,
                      title: 'Cuci Jas / Gaun',
                      price: 'Rp 23.000 / Plastik',
                      eta: 'Express',
                      etaType: EtaType.express,
                      imagePath: 'assets/images/jas.jpg',
                    ),
                    _gridCard(
                      context,
                      title: 'Setrika Saja',
                      price: 'Rp 21.000 / Plastik',
                      eta: 'ETA 10 jam',
                      etaType: EtaType.normal,
                      imagePath: 'assets/images/setrikasaja.jpeg',
                    ),
                  ],
                ),

                const SizedBox(
                  height: AppSpacing.xl,
                ),

                _bedcoverCard(
                  context,
                ),

                const SizedBox(
                  height: AppSpacing.lg,
                ),

                _shoesCard(
                  context,
                ),
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
    required String imagePath,
  }) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(
        AppSpacing.cardRadius,
      ),
      child: InkWell(
        onTap: () => _handleTap(
          context,
          () => Navigator.pushNamed(
            context,
            '/service-detail',
          ),
        ),
        borderRadius: BorderRadius.circular(
          AppSpacing.cardRadius,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(
                        16,
                      ),
                    ),
                    child: Image.asset(
                      imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (
                            c,
                            e,
                            s,
                          ) {
                            return Container(
                              color: AppColors.serviceCardTint,
                              child: const Center(
                                child: Icon(
                                  Icons.image_outlined,
                                  size: 42,
                                  color: AppColors.actionBlue,
                                ),
                              ),
                            );
                          },
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: EtaBadge(
                      label: eta,
                      type: etaType,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(
                  12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.sectionTitle.copyWith(
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      price,
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 11,
                      ),
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

  // ================= SPECIAL CARD =================
  Widget _specialCard(
    BuildContext context, {
    required String title,
    required String price,
    required IconData icon,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(
        AppSpacing.cardRadius,
      ),
      child: InkWell(
        onTap: () => _handleTap(
          context,
          () => Navigator.pushNamed(
            context,
            '/service-detail',
          ),
        ),
        borderRadius: BorderRadius.circular(
          AppSpacing.cardRadius,
        ),
        child: Container(
          padding: const EdgeInsets.all(
            14,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppSpacing.cardRadius,
            ),
            border: Border.all(
              color: AppColors.borderLight,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 76,
                height: 68,
                decoration: BoxDecoration(
                  color: AppColors.serviceCardTint,
                  borderRadius: BorderRadius.circular(
                    14,
                  ),
                ),
                child: Icon(
                  icon,
                  size: 34,
                  color: AppColors.actionBlue,
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.sectionTitle.copyWith(
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      price,
                      style: AppTextStyles.bodyMuted.copyWith(
                        fontSize: 12,
                      ),
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

  Widget _bedcoverCard(
    BuildContext context,
  ) {
    return _specialCard(
      context,
      title: 'Cuci Bedcover / Selimut / Sprei',
      price: 'Rp45.000 / Item',
      icon: Icons.local_laundry_service,
    );
  }

  Widget _shoesCard(
    BuildContext context,
  ) {
    return _specialCard(
      context,
      title: 'Cuci Sepatu',
      price: 'Rp22.000 / Pasang',
      icon: Icons.directions_walk,
    );
  }
}

// ================= NO OVERSCROLL =================
class _NoOverscrollBehavior
    extends
        ScrollBehavior {
  const _NoOverscrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) => child;

  @override
  ScrollPhysics getScrollPhysics(
    BuildContext context,
  ) => const ClampingScrollPhysics();
}
