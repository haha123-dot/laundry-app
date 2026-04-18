import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import '../widgets/info_kv_row.dart';
import '../widgets/navy_app_bar.dart';
import '../widgets/primary_button.dart';
import '../widgets/quantity_stepper.dart';
import '../widgets/rounded_white_panel.dart';

class ServiceDetailScreen
    extends
        StatefulWidget {
  const ServiceDetailScreen({
    super.key,
  });

  @override
  State<
    ServiceDetailScreen
  >
  createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState
    extends
        State<
          ServiceDetailScreen
        > {
  int _qty = 1;
  int _tab = 0;

  final int _pricePerItem = 20000;
  final int _deliveryFee = 5000;

  int get _serviceFee =>
      _pricePerItem *
      _qty;
  int get _total =>
      _serviceFee +
      _deliveryFee;

  String _formatRp(
    int value,
  ) {
    return 'Rp ${value.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: AppColors.headerNavy,
      appBar: NavyBackAppBar(
        title: 'Ringkasan Layanan',
        onBack: () => Navigator.pop(
          context,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: RoundedWhitePanel(
              topRadius: AppSpacing.sheetTopRadius,
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.xl,
                AppSpacing.xl,
                12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 44,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _tabChip(
                          0,
                          'Cuci Regular',
                          Icons.local_laundry_service,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        _tabChip(
                          1,
                          'Cuci Setrika',
                          Icons.iron,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        _tabChip(
                          2,
                          'Cuci Kering',
                          Icons.dry_cleaning_outlined,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: AppSpacing.xl,
                  ),

                  Text(
                    'Daftar Harga',
                    style: AppTextStyles.sectionTitle,
                  ),

                  const SizedBox(
                    height: AppSpacing.md,
                  ),

                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.local_laundry_service,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cuci regular',
                              style: AppTextStyles.sectionTitle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Rp 20.000 / Plastik',
                              style: AppTextStyles.bodyMuted,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        QuantityStepper(
                          value: _qty,
                          onChanged:
                              (
                                v,
                              ) => setState(
                                () => _qty = v,
                              ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  InfoKvRow(
                    label: 'Biaya Layanan',
                    value: _formatRp(
                      _serviceFee,
                    ),
                  ),
                  InfoKvRow(
                    label: 'Biaya Pengiriman',
                    value: _formatRp(
                      _deliveryFee,
                    ),
                  ),
                  InfoKvRow(
                    label: 'Estimasi Total',
                    value: _formatRp(
                      _total,
                    ),
                    valueBold: true,
                  ),

                  const SizedBox(
                    height: AppSpacing.md,
                  ),

                  PrimaryButton(
                    label: 'Jadwalkan Penjemputan',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/pickup-schedule',
                        arguments: {
                          'service': 'Cuci regular',
                          'qty': _qty,
                          'price': _pricePerItem,
                          'serviceFee': _serviceFee,
                          'deliveryFee': _deliveryFee,
                          'total': _total,
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabChip(
    int i,
    String label,
    IconData icon,
  ) {
    final sel =
        _tab ==
        i;

    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            label,
          ),
        ],
      ),
      selected: sel,
      onSelected:
          (
            _,
          ) => setState(
            () => _tab = i,
          ),
    );
  }
}
