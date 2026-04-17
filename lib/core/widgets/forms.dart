import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';

/// =======================================================
/// LABELED TEXT FIELD
/// =======================================================
class LabeledTextField extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.titleMedium?.copyWith(fontSize: 14),
        ),
        const SizedBox(height: AppDimens.sm),
        TextField(
          controller: controller,
          obscureText: obscure,
          maxLines: obscure ? 1 : maxLines,
          keyboardType: keyboardType,
          style: textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: textTheme.bodyMedium,
            filled: true,
            fillColor: AppColors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: AppColors.textSecondary,
                    size: 22,
                  )
                : null,
            suffixIcon: suffix,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(AppDimens.inputRadius),
              borderSide:
                  const BorderSide(color: AppColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(AppDimens.inputRadius),
              borderSide: const BorderSide(
                color: AppColors.borderLight,
                width: 1.2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(AppDimens.inputRadius),
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

/// =======================================================
/// SEARCH FIELD (ROUNDED)
/// =======================================================
class SearchFieldRounded extends StatelessWidget {
  const SearchFieldRounded({
    super.key,
    this.hint = 'Cari',
    this.onChanged,
  });

  final String hint;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextField(
      onChanged: onChanged,
      style: textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: textTheme.bodyMedium,
        prefixIcon:
            const Icon(Icons.search, color: AppColors.textSecondary),
        filled: true,
        fillColor: AppColors.inputFill,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppDimens.inputRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

/// =======================================================
/// QUANTITY STEPPER
/// =======================================================
class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _button(Icons.remove, () {
            onChanged(value > 1 ? value - 1 : 1);
          }),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDimens.md),
            child: Text(
              '$value',
              style:
                  textTheme.titleMedium?.copyWith(fontSize: 16),
            ),
          ),
          _button(Icons.add, () {
            onChanged(value + 1);
          }),
        ],
      ),
    );
  }

  Widget _button(IconData icon, VoidCallback onTap) {
    return Material(
      color: AppColors.mintSkip,
      borderRadius: icon == Icons.remove
          ? const BorderRadius.horizontal(
              left: Radius.circular(11))
          : const BorderRadius.horizontal(
              right: Radius.circular(11)),
      child: InkWell(
        onTap: onTap,
        borderRadius: icon == Icons.remove
            ? const BorderRadius.horizontal(
                left: Radius.circular(11))
            : const BorderRadius.horizontal(
                right: Radius.circular(11)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon,
              size: 18, color: AppColors.textDark),
        ),
      ),
    );
  }
}

/// =======================================================
/// PIN KEYPAD
/// =======================================================
class PinKeypad extends StatelessWidget {
  const PinKeypad({
    super.key,
    required this.onDigit,
    required this.onBackspace,
  });

  final ValueChanged<int> onDigit;
  final VoidCallback onBackspace;

  @override
  Widget build(BuildContext context) {
    final numStyle = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(fontSize: 26, color: AppColors.textDark);

    return Container(
      color: AppColors.keypadBg,
      padding:
          const EdgeInsets.fromLTRB(12, 8, 12, AppDimens.lg),
      child: Column(
        children: [
          _row([1, 2, 3], numStyle),
          _row([4, 5, 6], numStyle),
          _row([7, 8, 9], numStyle),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                child: _key(
                  Text('0', style: numStyle),
                  () => onDigit(0),
                ),
              ),
              Expanded(
                child: _key(
                  const Icon(Icons.backspace_outlined,
                      color: AppColors.textDark, size: 22),
                  onBackspace,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _row(List<int> nums, TextStyle? style) {
    return Row(
      children: nums
          .map(
            (n) => Expanded(
              child: _key(
                Text('$n', style: style),
                () => onDigit(n),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _key(Widget child, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child:
            const SizedBox(height: 52, child: Center()),
      ),
    );
  }
}