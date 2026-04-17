import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import '../widgets/labeled_text_field.dart';
import '../widgets/navy_app_bar.dart';
import '../widgets/primary_button.dart';
import '../widgets/rounded_white_panel.dart';

class PickupScheduleScreen extends StatelessWidget {
  const PickupScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.headerNavy,
      appBar: NavyBackAppBar(
        title: 'Pengambilan dan Pengantaran',
        onBack: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: RoundedWhitePanel(
              topRadius: AppSpacing.sheetTopRadius,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Waktu Pengambilan', style: AppTextStyles.sectionTitle.copyWith(fontSize: 15)),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(child: _dateField('Hari ini', Icons.calendar_today_outlined)),
                        const SizedBox(width: 10),
                        Expanded(child: _dateField('10.00 AM', Icons.access_time)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _iconField('Dijemput', Icons.person_outline),
                    const SizedBox(height: AppSpacing.xl),
                    Text('Waktu Pengantaran', style: AppTextStyles.sectionTitle.copyWith(fontSize: 15)),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(child: _dateField('Besok', Icons.calendar_today_outlined)),
                        const SizedBox(width: 10),
                        Expanded(child: _dateField('12.00 PM', Icons.access_time)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _iconField('Diantar', Icons.person_outline),
                    const SizedBox(height: AppSpacing.xl),
                    const LabeledTextField(
                      label: 'Alamat Pengiriman',
                      hint: 'Jln. Matahari no. 456',
                      prefixIcon: Icons.location_on_outlined,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text('Tambah catatan', style: AppTextStyles.sectionTitle.copyWith(fontSize: 14)),
                    const SizedBox(height: 8),
                    TextField(
                      maxLines: 4,
                      style: AppTextStyles.body,
                      decoration: InputDecoration(
                        hintText: 'Tulis disini',
                        hintStyle: AppTextStyles.bodyMuted,
                        filled: true,
                        fillColor: AppColors.inputFill,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    PrimaryButton(
                      label: 'Selanjutnya',
                      onPressed: () => Navigator.pushNamed(context, '/order-review'),
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

  Widget _dateField(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: AppTextStyles.body)),
        ],
      ),
    );
  }

  Widget _iconField(String text, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Text(text, style: AppTextStyles.body),
        ],
      ),
    );
  }
}
