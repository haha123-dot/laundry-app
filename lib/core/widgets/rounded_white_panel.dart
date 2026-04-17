import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';

/// White sheet overlapping navy header (home, profile, settings, etc.)
class RoundedWhitePanel extends StatelessWidget {
  const RoundedWhitePanel({
    super.key,
    required this.child,
    this.topRadius,
    this.padding,
  });

  final Widget child;
  final double? topRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final radius = topRadius ?? AppDimens.sheetTopRadius;

    return SizedBox.expand( // ✅ INI KUNCI UTAMA
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radius),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radius),
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(AppDimens.xl),
            child: child,
          ),
        ),
      ),
    );
  }
}