import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';

import '../../core/widgets/navigation.dart';
import '../../core/widgets/buttons.dart';
import '../../core/widgets/forms.dart';
import '../../core/widgets/info_kv_row.dart';
import '../../core/widgets/rounded_white_panel.dart';

class ServiceDetailScreen extends StatefulWidget {
  const ServiceDetailScreen({super.key});

  @override
  State<ServiceDetailScreen> createState() =>
      _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  int _qty = 1;
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.headerNavy,

      // ================= APP BAR =================
      appBar: NavyBackAppBar(
        title: 'Ringkasan Layanan',
        onBack: () => Navigator.pop(context),
      ),

      // ================= BODY =================
      body: Column(
        children: [
          const SizedBox(height: AppDimens.sm),
          Expanded(
            child: RoundedWhitePanel(
              topRadius: AppDimens.sheetTopRadius,
              padding: const EdgeInsets.fromLTRB(
                AppDimens.xl,
                AppDimens.xl,
                AppDimens.xl,
                12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ================= SERVICE TABS =================
                  SizedBox(
                    height: 44,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _tabChip(
                          context,
                          0,
                          'Cuci Regular',
                          Icons.local_laundry_service,
                        ),
                        const SizedBox(width: 10),
                        _tabChip(
                          context,
                          1,
                          'Cuci Kering',
                          Icons.dry_cleaning_outlined,
                        ),
                        const SizedBox(width: 10),
                        _tabChip(
                          context,
                          2,
                          'Cuci Satuan',
                          Icons.checkroom_outlined,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppDimens.lg),

                  /// ================= SERVICE INFO =================
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppDimens.lg),
                    decoration: BoxDecoration(
                      color: AppColors.serviceCardTint,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cuci Regular',
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Untuk cucian sehari-hari, pakaian, sprei, dan handuk',
                          style: textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: PrimaryButton(
                            label: 'Pelajari lebih lanjut',
                            onPressed: () {},
                            height: 36,
                            borderRadius: 10,
                            expanded: false,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppDimens.xl),

                  /// ================= PRICE LIST =================
                  Text(
                    'Daftar Harga',
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppDimens.md),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 56,
                          height: 56,
                          color: AppColors.serviceCardTint,
                          child: const Icon(
                            Icons.local_laundry_service,
                            color: AppColors.actionBlue,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cuci Regular',
                              style: textTheme.titleMedium
                                  ?.copyWith(fontSize: 14),
                            ),
                            Text(
                              'Rp 20.000 / Plastik',
                              style: textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      QuantityStepper(
                        value: _qty,
                        onChanged: (v) =>
                            setState(() => _qty = v),
                      ),
                    ],
                  ),

                  const Spacer(),

                  /// ================= TOTAL =================
                  const InfoKvRow(
                    label: 'Biaya Layanan',
                    value: 'Rp 20.000',
                  ),
                  const InfoKvRow(
                    label: 'Biaya Pengiriman',
                    value: 'Rp 5.000',
                  ),
                  const InfoKvRow(
                    label: 'Estimasi Total',
                    value: 'Rp 25.000',
                    valueBold: true,
                  ),

                  const SizedBox(height: AppDimens.md),

                  PrimaryButton(
                    label: 'Jadwalkan Penjemputan',
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/pickup-schedule',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= TAB CHIP =================
  Widget _tabChip(
    BuildContext context,
    int i,
    String label,
    IconData icon,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final selected = _tab == i;

    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: selected
                ? AppColors.actionBlue
                : AppColors.textSecondary,
          ),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
      selected: selected,
      onSelected: (_) => setState(() => _tab = i),
      selectedColor: AppColors.serviceCardTint,
      backgroundColor: AppColors.white,
      showCheckmark: false,
      labelStyle: textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: selected
            ? AppColors.headerNavy
            : AppColors.textSecondary,
      ),
      side: BorderSide(
        color: selected
            ? AppColors.actionBlue
            : AppColors.borderLight,
      ),
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    );
  }
}