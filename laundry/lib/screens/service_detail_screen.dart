import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import '../widgets/info_kv_row.dart';
import '../widgets/navy_app_bar.dart';
import '../widgets/primary_button.dart';
import '../widgets/quantity_stepper.dart';
import '../widgets/rounded_white_panel.dart';

class ServiceDetailScreen extends StatefulWidget {
  const ServiceDetailScreen({super.key});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  int _qty = 1;
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.headerNavy,
      appBar: NavyBackAppBar(
        title: 'Ringkasan Layanan',
        onBack: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: RoundedWhitePanel(
              topRadius: AppSpacing.sheetTopRadius,
              padding: const EdgeInsets.fromLTRB(AppSpacing.xl, AppSpacing.xl, AppSpacing.xl, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 44,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _tabChip(0, 'Cuci Regular', Icons.local_laundry_service),
                        const SizedBox(width: 10),
                        _tabChip(1, 'Cuci Kering', Icons.dry_cleaning_outlined),
                        const SizedBox(width: 10),
                        _tabChip(2, 'Cuci Satuan', Icons.checkroom_outlined),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.serviceCardTint,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cuci Regular', style: AppTextStyles.sectionTitle),
                        const SizedBox(height: 8),
                        Text(
                          'Untuk cucian sehari-hari, pakaian, sprei, dan handuk',
                          style: AppTextStyles.bodyMuted,
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 36,
                            child: PrimaryButton(
                              label: 'Pelajari lebih lanjut',
                              onPressed: () {},
                              height: 36,
                              borderRadius: 10,
                              expanded: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text('Daftar Harga', style: AppTextStyles.sectionTitle),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 56,
                          height: 56,
                          color: AppColors.serviceCardTint,
                          child: const Icon(Icons.local_laundry_service, color: AppColors.actionBlue, size: 30),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cuci regular', style: AppTextStyles.sectionTitle.copyWith(fontSize: 14)),
                            Text('Rp 20.000 / Plastik', style: AppTextStyles.bodyMuted),
                          ],
                        ),
                      ),
                      QuantityStepper(
                        value: _qty,
                        onChanged: (v) => setState(() => _qty = v),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const InfoKvRow(label: 'Biaya Layanan', value: 'Rp 20.000'),
                  const InfoKvRow(label: 'Biaya Pengiriman', value: 'Rp 5.000'),
                  const InfoKvRow(label: 'Estimasi Total', value: 'Rp 25.000', valueBold: true),
                  const SizedBox(height: AppSpacing.md),
                  PrimaryButton(
                    label: 'Jadwalkan Penjemputan',
                    onPressed: () => Navigator.pushNamed(context, '/pickup-schedule'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabChip(int i, String label, IconData icon) {
    final sel = _tab == i;
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: sel ? AppColors.actionBlue : AppColors.textSecondary),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
      selected: sel,
      onSelected: (_) => setState(() => _tab = i),
      selectedColor: AppColors.serviceCardTint,
      labelStyle: AppTextStyles.body.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: sel ? AppColors.headerNavy : AppColors.textSecondary,
      ),
      side: BorderSide(color: sel ? AppColors.actionBlue : AppColors.borderLight),
      backgroundColor: AppColors.white,
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    );
  }
}
