import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';

/// =======================================================
/// PRIMARY BUTTON
/// =======================================================
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.backgroundColor = AppColors.primaryNavy,
    this.foregroundColor = AppColors.white,
    this.expanded = true,
    this.height = 52,
    this.borderRadius = AppDimens.buttonRadius,
    this.leading,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool expanded;
  final double height;
  final double borderRadius;
  final Widget? leading;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final child = loading
        ? SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: foregroundColor,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: AppDimens.sm),
              ],
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: foregroundColor),
              ),
            ],
          );

    final button = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: loading ? null : onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Ink(
          height: height,
          decoration: BoxDecoration(
            color: onPressed == null && !loading
                ? backgroundColor.withOpacity(0.5)
                : backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Center(child: child),
        ),
      ),
    );

    return expanded
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}

/// =======================================================
/// OUTLINE NAVY BUTTON
/// =======================================================
class OutlineNavyButton extends StatelessWidget {
  const OutlineNavyButton({
    super.key,
    required this.label,
    this.onPressed,
    this.leading,
    this.expanded = true,
    this.height = 52,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? leading;
  final bool expanded;
  final double height;

  @override
  Widget build(BuildContext context) {
    final child = Material(
      color: AppColors.white,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppDimens.buttonRadius),
        child: Container(
          height: height,
          padding:
              const EdgeInsets.symmetric(horizontal: AppDimens.lg),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(AppDimens.buttonRadius),
            border: Border.all(
              color: AppColors.primaryNavy,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: AppDimens.sm),
              ],
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: AppColors.primaryNavy),
              ),
            ],
          ),
        ),
      ),
    );

    return expanded
        ? SizedBox(width: double.infinity, child: child)
        : child;
  }
}