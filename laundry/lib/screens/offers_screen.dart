import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import '../widgets/navy_app_bar.dart';
import '../widgets/login_modal_sheet.dart';

class OffersScreen
    extends
        StatelessWidget {
  const OffersScreen({
    super.key,
    this.onOpenNotifications,
    this.loggedIn = false,
  });

  final VoidCallback? onOpenNotifications;
  final bool loggedIn;

  void _handleTap(
    BuildContext context,
  ) {
    if (!loggedIn) {
      showLoginModal(
        context,
      );
      return;
    }

    onOpenNotifications?.call();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return ColoredBox(
      color: AppColors.headerNavy,
      child: Column(
        children: [
          NavyCenterTitleAppBar(
            title: 'Tawaranku',
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                ),
                child: GestureDetector(
                  onTap: () => _handleTap(
                    context,
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

          Expanded(
            child: Container(
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
                    Text(
                      'Tawaran Pengguna Baru',
                      style: AppTextStyles.sectionTitle,
                    ),
                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    _promoCard(
                      title: 'Diskon 15% untuk Pengguna Baru',
                      subtitle: 'gunakan kode: SSSd789',
                      imagePath: 'assets/images/promo.png',
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    Text(
                      'Penawaran Khusus',
                      style: AppTextStyles.sectionTitle,
                    ),
                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    _promoCard(
                      title: 'Payday Sale Diskon Rp10.000',
                      subtitle: 'minimal transaksi Rp45.000',
                      imagePath: 'assets/images/pay.png',
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    _promoCard(
                      title: 'Cuci Bedcover Diskon 10%',
                      subtitle: 'selama bulan Juli',
                      imagePath: 'assets/images/bedcover.png',
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

  Widget _promoCard({
    required String title,
    required String subtitle,
    required String imagePath,
  }) {
    return Container(
      height: 130,
      padding: const EdgeInsets.all(
        14,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(
              0xFFD2E6FF,
            ),
            Color(
              0xFFAADDEE,
            ),
          ],
        ),
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.sectionTitle.copyWith(
                    fontSize: 13,
                    color: const Color(
                      0xFF0D1B2A,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  subtitle,
                  style: AppTextStyles.bodyMuted.copyWith(
                    fontSize: 12,
                    color:
                        const Color(
                          0xFF0D1B2A,
                        ).withOpacity(
                          0.7,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 32,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF070066,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          18,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Gunakan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            width: 10,
          ),

          ClipRRect(
            borderRadius: BorderRadius.circular(
              14,
            ),
            child: Image.asset(
              imagePath,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              errorBuilder:
                  (
                    c,
                    e,
                    s,
                  ) => Container(
                    width: 64,
                    height: 64,
                    color: Colors.white24,
                    child: const Icon(
                      Icons.image_outlined,
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
