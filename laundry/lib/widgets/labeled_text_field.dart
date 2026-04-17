import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';

class LabeledTextField
    extends
        StatelessWidget {
  const LabeledTextField({
    super.key,
    required this.label,
    required this.hint,
    this.prefixIcon,
    this.suffix,
    this.obscure = false,
    this.maxLines = 1,
    this.controller,
    this.keyboardType,
  });

  final String label;
  final String hint;
  final IconData? prefixIcon;
  final Widget? suffix;
  final bool obscure;
  final int maxLines;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.sectionTitle.copyWith(
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 8,
        ),

        TextField(
          controller: controller,
          obscureText: obscure,
          maxLines: obscure
              ? 1
              : maxLines,
          keyboardType: keyboardType,
          style: AppTextStyles.body,

          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.bodyMuted,
            filled: true,
            fillColor: AppColors.white,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),

            prefixIcon:
                prefixIcon !=
                    null
                ? Icon(
                    prefixIcon,
                    color: AppColors.textSecondary,
                    size: 22,
                  )
                : null,

            suffixIcon: suffix,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppSpacing.inputRadius,
              ),
              borderSide: const BorderSide(
                color: AppColors.borderLight,
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppSpacing.inputRadius,
              ),
              borderSide: const BorderSide(
                color: AppColors.borderLight,
                width: 1.2,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppSpacing.inputRadius,
              ),
              borderSide: const BorderSide(
                color: AppColors.primaryNavy,
                width: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
