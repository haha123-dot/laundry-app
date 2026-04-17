import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/widgets/buttons.dart';
import '../../core/widgets/forms.dart';

class PinEntryScreen extends StatefulWidget {
  const PinEntryScreen({
    super.key,
    required this.walletName,
  });

  final String walletName;

  @override
  State<PinEntryScreen> createState() => _PinEntryScreenState();
}

class _PinEntryScreenState extends State<PinEntryScreen> {
  final List<int> _digits = [];

  void _add(int d) {
    if (_digits.length >= 6) return;
    setState(() => _digits.add(d));
  }

  void _back() {
    if (_digits.isEmpty) return;
    setState(() => _digits.removeLast());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final title = 'Masukkan PIN ${widget.walletName} Anda';

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leadingWidth: 100,
        leading: TextButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left,
            color: AppColors.headerNavy,
            size: 28,
          ),
          label: Text(
            'Kembali',
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.headerNavy,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: textTheme.titleMedium,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: AppDimens.xl),

          /// PIN DOTS
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(6, (i) {
              final filled = i < _digits.length;

              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: AppDimens.sm),
                width: 44,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius:
                      BorderRadius.circular(AppDimens.radiusSm),
                  border: Border.all(
                    color: AppColors.actionBlue.withOpacity(
                      i == 0 && _digits.isEmpty ? 0.9 : 0.25,
                    ),
                    width: 1.2,
                  ),
                ),
                alignment: Alignment.center,
                child: filled
                    ? Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: AppColors.headerNavy,
                          shape: BoxShape.circle,
                        ),
                      )
                    : null,
              );
            }),
          ),

          const SizedBox(height: AppDimens.xl),

          /// CONFIRM BUTTON
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDimens.xl),
            child: PrimaryButton(
              label: 'Konfirmasi',
              backgroundColor: AppColors.actionBlue,
              onPressed: _digits.length == 6
                  ? () => Navigator.popUntil(
                        context,
                        (r) => r.isFirst,
                      )
                  : null,
            ),
          ),

          const Spacer(),

          /// PIN KEYPAD
          PinKeypad(
            onDigit: _add,
            onBackspace: _back,
          ),
        ],
      ),
    );
  }
}
