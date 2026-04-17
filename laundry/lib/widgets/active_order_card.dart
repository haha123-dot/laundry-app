import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import 'step_progress_bar.dart';

class ActiveOrderCard
    extends
        StatelessWidget {
  const ActiveOrderCard({
    super.key,
    required this.statusTitle,
    required this.subtitle,
    this.badgeLabel = 'Diproses',
    this.currentStep = 1,
    this.empty = false,
    this.onTap,
  });

  final String statusTitle;
  final String subtitle;
  final String badgeLabel;
  final int currentStep;
  final bool empty;
  final VoidCallback? onTap;

  static const double _cardHeight = 200; // ± 5 cm

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      width: double.infinity,
      height: _cardHeight,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(
            AppSpacing.cardRadius,
          ),
          child: Container(
            width: double.infinity,
            height: _cardHeight,
            padding: const EdgeInsets.all(
              AppSpacing.lg,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(
                AppSpacing.cardRadius,
              ),
              border: Border.all(
                color: AppColors.borderLight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: 0.05,
                  ),
                  blurRadius: 12,
                  offset: const Offset(
                    0,
                    4,
                  ),
                ),
              ],
            ),

            /// ================= EMPTY STATE =================
            child: empty
                ? Center(
                    child: Text(
                      'Tidak ada pesanan aktif untuk saat ini',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMuted,
                    ),
                  )
                /// ================= NORMAL STATE =================
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              statusTitle,
                              style: AppTextStyles.sectionTitle.copyWith(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.successBg,
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            child: Text(
                              badgeLabel,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.success,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),

                      Text(
                        subtitle,
                        style: AppTextStyles.bodyMuted,
                      ),

                      const Spacer(),

                      OrderStepProgressBar(
                        activeIndex: currentStep,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
