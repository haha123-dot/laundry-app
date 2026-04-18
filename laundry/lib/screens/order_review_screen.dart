import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import '../widgets/info_kv_row.dart';
import '../widgets/navy_app_bar.dart';
import '../widgets/rounded_white_panel.dart';
import '../widgets/service_summary_tile.dart';

class OrderReviewScreen
    extends
        StatefulWidget {
  const OrderReviewScreen({
    super.key,
  });

  @override
  State<
    OrderReviewScreen
  >
  createState() => _OrderReviewScreenState();
}

class _OrderReviewScreenState
    extends
        State<
          OrderReviewScreen
        > {
  bool _payLoading = false;

  String _formatRp(
    dynamic value,
  ) {
    final v =
        (value ??
                0)
            .toString();
    return 'Rp $v';
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final args =
        (ModalRoute.of(
              context,
            )?.settings.arguments
            as Map?) ??
        {};

    return Scaffold(
      backgroundColor: AppColors.headerNavy,
      appBar: NavyBackAppBar(
        title: 'Tinjau Pesanan',
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
              padding: const EdgeInsets.all(
                AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ServiceSummaryTile(
                    title:
                        args['service'] ??
                        'Service',
                    priceLabel: 'Rp ${args['price'] ?? 0} / Plastik',
                    onEdit: () => Navigator.pop(
                      context,
                    ),
                  ),

                  const Divider(
                    height: 32,
                  ),

                  InfoKvRow(
                    label: 'Waktu Pengambilan',
                    value:
                        args['pickupTime'] ??
                        '-',
                    valueBold: true,
                  ),

                  InfoKvRow(
                    label: 'Waktu Pengiriman',
                    value:
                        args['deliveryTime'] ??
                        '-',
                    valueBold: true,
                  ),

                  InfoKvRow(
                    label: 'Alamat Pengiriman',
                    value:
                        args['address'] ??
                        '-',
                    valueBold: true,
                  ),

                  const SizedBox(
                    height: AppSpacing.lg,
                  ),

                  Text(
                    'Detail Pembayaran:',
                    style: AppTextStyles.sectionTitle.copyWith(
                      fontSize: 14,
                    ),
                  ),

                  InfoKvRow(
                    label: 'Biaya Layanan',
                    value: _formatRp(
                      args['serviceFee'],
                    ),
                  ),

                  InfoKvRow(
                    label: 'Biaya Pengiriman',
                    value: _formatRp(
                      args['deliveryFee'],
                    ),
                  ),

                  InfoKvRow(
                    label: 'Kode Promo',
                    value: '-',
                  ),

                  InfoKvRow(
                    label: 'Total Pembayaran',
                    value: _formatRp(
                      args['total'],
                    ),
                    valueBold: true,
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.headerNavy,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSpacing.buttonRadius,
                          ),
                        ),
                      ),
                      onPressed: _payLoading
                          ? null
                          : () async {
                              setState(
                                () => _payLoading = true,
                              );

                              await Future.delayed(
                                const Duration(
                                  milliseconds: 600,
                                ),
                              );

                              if (!context.mounted) return;

                              setState(
                                () => _payLoading = false,
                              );

                              Navigator.pushNamed(
                                context,
                                '/payment', // ✅ FIX
                                arguments: args,
                              );
                            },
                      child: _payLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                          : Text(
                              'Bayar',
                              style: AppTextStyles.sectionTitle.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                              ),
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
