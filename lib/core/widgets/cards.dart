import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import 'indicators.dart';

/// =======================================================
/// ACTIVE ORDER CARD
/// =======================================================
class ActiveOrderCard extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (empty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppDimens.xxl),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimens.cardRadius),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Text(
          'Tidak ada pesanan aktif untuk saat ini',
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium,
        ),
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimens.cardRadius),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppDimens.lg),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppDimens.cardRadius),
            border: Border.all(color: AppColors.borderLight),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      statusTitle,
                      style: textTheme.titleMedium?.copyWith(fontSize: 15),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.successBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      badgeLabel,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimens.sm),
              Text(subtitle, style: textTheme.bodyMedium),
              const SizedBox(height: AppDimens.lg),
              OrderStepProgressBar(activeIndex: currentStep),
            ],
          ),
        ),
      ),
    );
  }
}

/// =======================================================
/// PESANAN ORDER CARD
/// =======================================================
class PesananOrderCard extends StatelessWidget {
  const PesananOrderCard({
    super.key,
    required this.customerName,
    required this.orderId,
    required this.dateLabel,
    required this.serviceTitle,
    required this.priceLabel,
    required this.qty,
    required this.shippingLabel,
    required this.totalLabel,
    this.highlightBorder = false,
  });

  final String customerName;
  final String orderId;
  final String dateLabel;
  final String serviceTitle;
  final String priceLabel;
  final int qty;
  final String shippingLabel;
  final String totalLabel;
  final bool highlightBorder;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.lg),
      padding: const EdgeInsets.all(AppDimens.lg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.cardRadius),
        border: Border.all(
          color:
              highlightBorder ? AppColors.actionBlue : AppColors.borderLight,
          width: highlightBorder ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.iconCircle,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.notifications_none,
                        size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      'Pesanan',
                      style: textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(dateLabel, style: textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: AppDimens.md),
          Text(customerName,
              style:
                  textTheme.titleMedium?.copyWith(color: AppColors.textDark)),
          const SizedBox(height: 4),
          Text(orderId, style: textTheme.bodyLarge),
          const SizedBox(height: AppDimens.md),
          _ServiceInfoBox(
            serviceTitle: serviceTitle,
            priceLabel: priceLabel,
            qty: qty,
          ),
          const SizedBox(height: AppDimens.sm),
          Align(
            alignment: Alignment.centerRight,
            child: Text(shippingLabel, style: textTheme.bodySmall),
          ),
          const Divider(height: 24),
          Row(
            children: [
              Text('Total:',
                  style: textTheme.titleMedium?.copyWith(fontSize: 15)),
              const Spacer(),
              Text(totalLabel,
                  style: textTheme.titleMedium?.copyWith(fontSize: 15)),
            ],
          ),
        ],
      ),
    );
  }
}

/// =======================================================
/// SERVICE CARD (COMPACT)
/// =======================================================
class ServiceCardCompact extends StatelessWidget {
  const ServiceCardCompact({
    super.key,
    required this.title,
    required this.priceLabel,
    required this.etaLabel,
    this.etaType = EtaType.normal,
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
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimens.cardRadius),
        child: Container(
          width: 148,
          padding: const EdgeInsets.all(AppDimens.md),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppDimens.cardRadius),
            border: Border.all(
              color: selected
                  ? AppColors.actionBlue
                  : AppColors.borderLight,
              width: selected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 22, color: AppColors.actionBlue),
                  const Spacer(),
                  EtaBadge(label: etaLabel, type: etaType),
                ],
              ),
              const SizedBox(height: AppDimens.sm),
              Text(title,
                  style:
                      textTheme.titleMedium?.copyWith(fontSize: 14)),
              const SizedBox(height: 4),
              Text(priceLabel, style: textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

/// =======================================================
/// SERVICE SUMMARY
/// =======================================================
class ServiceSummaryTile extends StatelessWidget {
  const ServiceSummaryTile({
    super.key,
    required this.title,
    required this.priceLabel,
    this.onEdit,
  });

  final String title;
  final String priceLabel;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.serviceCardTint,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.local_laundry_service,
              color: AppColors.actionBlue),
        ),
        const SizedBox(width: AppDimens.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style:
                      textTheme.titleMedium?.copyWith(fontSize: 15)),
              const SizedBox(height: 4),
              Text(priceLabel, style: textTheme.bodyMedium),
            ],
          ),
        ),
        if (onEdit != null)
          TextButton(
            onPressed: onEdit,
            child:
                Text('Edit', style: textTheme.labelLarge?.copyWith(
                  color: AppColors.linkBlue,
                )),
          ),
      ],
    );
  }
}

/// =======================================================
/// PAYMENT METHOD
/// =======================================================
class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.title,
    this.connected = false,
    this.leading,
  });

  final String title;
  final bool connected;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppDimens.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.cardRadius),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: AppDimens.md),
          ],
          Expanded(
            child: Text(title,
                style:
                    textTheme.titleMedium?.copyWith(fontSize: 15)),
          ),
          if (connected)
            Row(
              children: [
                Text(
                  'Terhubung',
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.check_circle,
                    color: AppColors.success, size: 20),
              ],
            ),
        ],
      ),
    );
  }
}

/// =======================================================
/// PRIVATE HELPER
/// =======================================================
class _ServiceInfoBox extends StatelessWidget {
  const _ServiceInfoBox({
    required this.serviceTitle,
    required this.priceLabel,
    required this.qty,
  });

  final String serviceTitle;
  final String priceLabel;
  final int qty;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.serviceCardTint,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.local_laundry_service,
                color: AppColors.actionBlue),
          ),
          const SizedBox(width: AppDimens.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(serviceTitle,
                    style:
                        textTheme.titleMedium?.copyWith(fontSize: 14)),
                Text(priceLabel, style: textTheme.bodySmall),
              ],
            ),
          ),
          Text('$qty',
              style:
                  textTheme.titleMedium?.copyWith(fontSize: 16)),
        ],
      ),
    );
  }
}
class ServiceNextCard extends StatelessWidget {
  const ServiceNextCard({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppDimens.cardRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimens.cardRadius),
        child: Container(
          width: 56,
          height: 120,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.cardRadius),
            border: Border.all(color: AppColors.borderLight),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
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
class WalletLogoBox extends StatelessWidget {
  const WalletLogoBox({
    super.key,
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: textTheme.titleMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}