import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class InfoKvRow extends StatelessWidget {
  const InfoKvRow({
    super.key,
    required this.label,
    required this.value,
    this.valueBold = false,
  });

  final String label;
  final String value;
  final bool valueBold;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              label,
              style: textTheme.bodyMedium,
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: valueBold
                  ? textTheme.titleMedium?.copyWith(fontSize: 14)
                  : textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentDividerLabel extends StatelessWidget {
  const PaymentDividerLabel({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        const Expanded(
          child: Divider(color: AppColors.borderLight),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const Expanded(
          child: Divider(color: AppColors.borderLight),
        ),
      ],
    );
  }
}