import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';

import '../../core/widgets/navigation.dart';
import '../../core/widgets/rounded_white_panel.dart';
import '../../core/widgets/forms.dart';
import '../../core/widgets/buttons.dart';

class PickupScheduleScreen extends StatelessWidget {
  const PickupScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.headerNavy,

      // ================= APP BAR =================
      appBar: NavyBackAppBar(
        title: 'Pengambilan dan Pengantaran',
        onBack: () => Navigator.pop(context),
      ),

      // ================= BODY =================
      body: Column(
        children: [
          const SizedBox(height: AppDimens.sm),
          Expanded(
            child: RoundedWhitePanel(
              topRadius: AppDimens.sheetTopRadius,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimens.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Waktu Pengambilan',
                      style:
                          textTheme.titleMedium?.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: AppDimens.md),

                    Row(
                      children: [
                        Expanded(
                          child: _dateField(
                            context,
                            'Hari ini',
                            Icons.calendar_today_outlined,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _dateField(
                            context,
                            '10.00 AM',
                            Icons.access_time,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    _iconField(
                      context,
                      'Dijemput',
                      Icons.person_outline,
                    ),

                    const SizedBox(height: AppDimens.xl),

                    Text(
                      'Waktu Pengantaran',
                      style:
                          textTheme.titleMedium?.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: AppDimens.md),

                    Row(
                      children: [
                        Expanded(
                          child: _dateField(
                            context,
                            'Besok',
                            Icons.calendar_today_outlined,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _dateField(
                            context,
                            '12.00 PM',
                            Icons.access_time,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    _iconField(
                      context,
                      'Diantar',
                      Icons.person_outline,
                    ),

                    const SizedBox(height: AppDimens.xl),

                    const LabeledTextField(
                      label: 'Alamat Pengiriman',
                      hint: 'Jln. Matahari no. 456',
                      prefixIcon: Icons.location_on_outlined,
                    ),

                    const SizedBox(height: AppDimens.xl),

                    Text(
                      'Tambah catatan',
                      style:
                          textTheme.titleMedium?.copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: AppDimens.sm),

                    TextField(
                      maxLines: 4,
                      style: textTheme.bodyLarge,
                      decoration: InputDecoration(
                        hintText: 'Tulis di sini',
                        hintStyle: textTheme.bodyMedium,
                        filled: true,
                        fillColor: AppColors.inputFill,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimens.inputRadius,
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: AppDimens.xxl),

                    PrimaryButton(
                      label: 'Selanjutnya',
                      onPressed: () => Navigator.pushNamed(
                        context,
                        '/order-review',
                      ),
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

  // ================= DATE FIELD =================
  Widget _dateField(
    BuildContext context,
    String text,
    IconData icon,
  ) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius:
            BorderRadius.circular(AppDimens.inputRadius),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: AppDimens.sm),
          Expanded(
            child: Text(
              text,
              style: textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  // ================= ICON FIELD =================
  Widget _iconField(
    BuildContext context,
    String text,
    IconData icon,
  ) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius:
            BorderRadius.circular(AppDimens.inputRadius),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: AppDimens.sm),
          Text(
            text,
            style: textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
