import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import '../widgets/info_kv_row.dart';
import '../widgets/navy_app_bar.dart';
import '../widgets/rounded_white_panel.dart';
import '../widgets/service_summary_tile.dart';

class OrderReviewScreen extends StatefulWidget {
  const OrderReviewScreen({super.key});

  @override
  State<OrderReviewScreen> createState() => _OrderReviewScreenState();
}

class _OrderReviewScreenState extends State<OrderReviewScreen> {
  bool _payLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.headerNavy,
      appBar: NavyBackAppBar(
        title: 'Tinjau Pesanan',
        onBack: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: RoundedWhitePanel(
              topRadius: AppSpacing.sheetTopRadius,
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ServiceSummaryTile(
                    title: 'Cuci regular',
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
                    value: 'Jln. Matahari no. 456',
                    valueBold: true,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('Detail Pembayaran:', style: AppTextStyles.sectionTitle.copyWith(fontSize: 14)),
                  const InfoKvRow(label: 'Biaya Layanan', value: 'Rp 20.000'),
                  const InfoKvRow(label: 'Biaya Pengiriman', value: 'Rp 5.000'),
                  const InfoKvRow(label: 'Kode Promo', value: '-'),
                  const InfoKvRow(label: 'Total Pembayaran', value: 'Rp 25.000', valueBold: true),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.inputFill,
                        foregroundColor: AppColors.headerNavy,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.buttonRadius)),
                      ),
                      onPressed: _payLoading
                          ? null
                          : () async {
                              setState(() => _payLoading = true);
                              await Future<void>.delayed(const Duration(milliseconds: 600));
                              if (!context.mounted) return;
                              setState(() => _payLoading = false);
                              Navigator.pushNamed(context, '/payment');
                            },
                      child: _payLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text('Bayar', style: AppTextStyles.sectionTitle.copyWith(fontSize: 16)),
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
