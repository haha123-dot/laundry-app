import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';

import '../../core/widgets/navigation.dart';
import '../../core/widgets/rounded_white_panel.dart';
import '../../core/widgets/cards.dart';
import '../../core/widgets/info_kv_row.dart';

class OrderReviewScreen extends StatefulWidget {
  const OrderReviewScreen({super.key});

  @override
  State<OrderReviewScreen> createState() => _OrderReviewScreenState();
}

class _OrderReviewScreenState extends State<OrderReviewScreen> {
  bool _payLoading = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.headerNavy,

      // ================= APP BAR =================
      appBar: NavyBackAppBar(
        title: 'Tinjau Pesanan',
        onBack: () => Navigator.pop(context),
      ),

      // ================= BODY =================
      body: Column(
        children: [
          const SizedBox(height: AppDimens.sm),
          Expanded(
            child: RoundedWhitePanel(
              topRadius: AppDimens.sheetTopRadius,
              padding: const EdgeInsets.all(AppDimens.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ServiceSummaryTile(
                    title: 'Cuci Regular',
                    priceLabel: 'Rp 20.000 / Plastik',
                    onEdit: () => Navigator.pop(context),
                  ),

                  const Divider(height: 32),

                  const InfoKvRow(
                    label: 'Waktu Pengambilan',
                    value: 'Hari ini, 10.00 AM',
                    valueBold: true,
                  ),
                  const InfoKvRow(
                    label: 'Waktu Pengiriman',
                    value: 'Besok, 12.00 PM',
                    valueBold: true,
                  ),
                  const InfoKvRow(
                    label: 'Alamat Pengiriman',
                    value: 'Jln. Matahari No. 456',
                    valueBold: true,
                  ),

                  const SizedBox(height: AppDimens.lg),

                  Text(
                    'Detail Pembayaran:',
                    style: textTheme.titleMedium?.copyWith(fontSize: 14),
                  ),

                  const InfoKvRow(
                      label: 'Biaya Layanan', value: 'Rp 20.000'),
                  const InfoKvRow(
                      label: 'Biaya Pengiriman', value: 'Rp 5.000'),
                  const InfoKvRow(label: 'Kode Promo', value: '-'),
                  const InfoKvRow(
                    label: 'Total Pembayaran',
                    value: 'Rp 25.000',
                    valueBold: true,
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: AppDimens.buttonHeight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.inputFill,
                        foregroundColor: AppColors.headerNavy,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              AppDimens.buttonRadius),
                        ),
                      ),
                      onPressed: _payLoading
                          ? null
                          : () async {
                              setState(() => _payLoading = true);
                              await Future<void>.delayed(
                                const Duration(milliseconds: 600),
                              );
                              if (!context.mounted) return;
                              setState(() => _payLoading = false);
                              Navigator.pushNamed(context, '/payment');
                            },
                      child: _payLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Bayar',
                              style: textTheme.titleMedium
                                  ?.copyWith(fontSize: 16),
                            ),
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
}