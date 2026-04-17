import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import 'eta_badge.dart';

class ServiceCardCompact
    extends
        StatelessWidget {
  const ServiceCardCompact({
    super.key,
    required this.title,
    required this.priceLabel,
    required this.etaLabel,
    this.etaType = EtaType.normal, // ✅ SATU-SATUNYA sumber warna ETA
    this.selected = false,
    this.icon = Icons.local_laundry_service_outlined,
    this.onTap,
  });

  final String title;
  final String priceLabel;
  final String etaLabel;
  final EtaType etaType;
  final bool selected;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          AppSpacing.cardRadius,
        ),
        child: Container(
          width: 148,
          padding: const EdgeInsets.all(
            12,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(
              AppSpacing.cardRadius,
            ),
            border: Border.all(
              color: selected
                  ? AppColors.actionBlue
                  : AppColors.borderLight,
              width: selected
                  ? 2
                  : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(
                  0.04,
                ),
                blurRadius: 10,
                offset: const Offset(
                  0,
                  4,
                ),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 22,
                    color: AppColors.actionBlue,
                  ),
                  const Spacer(),
                  EtaBadge(
                    label: etaLabel,
                    type: etaType, // ✅ VALID & TIDAK ERROR
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: AppTextStyles.sectionTitle.copyWith(
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                priceLabel,
                style: AppTextStyles.price.copyWith(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ================= PANAH KE SEMUA LAYANAN =================

class ServiceNextCard
    extends
        StatelessWidget {
  const ServiceNextCard({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(
        AppSpacing.cardRadius,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          AppSpacing.cardRadius,
        ),
        child: Container(
          width: 56,
          height: 120,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppSpacing.cardRadius,
            ),
            border: Border.all(
              color: AppColors.borderLight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(
                  0.04,
                ),
                blurRadius: 8,
              ),
            ],
          ),
          child: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.actionBlue,
            size: 20,
          ),
        ),
      ),
    );
  }
}
