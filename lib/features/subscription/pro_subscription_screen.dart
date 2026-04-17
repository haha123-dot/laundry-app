import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';

import '../../core/widgets/navigation.dart';
import '../../core/widgets/buttons.dart';
import '../../core/widgets/rounded_white_panel.dart';

class ProSubscriptionScreen extends StatefulWidget {
  const ProSubscriptionScreen({super.key});

  @override
  State<ProSubscriptionScreen> createState() =>
      _ProSubscriptionScreenState();
}

class _ProSubscriptionScreenState extends State<ProSubscriptionScreen> {
  String _planLabel = '6 Bulan';
  String _planPrice = 'Rp210.000';

  void _openPlanPicker() {
    final plans = <(String, String)>[
      ('6 Bulan', 'Rp210.000'),
      ('3 Bulan', 'Rp175.000'),
      ('1 Bulan', 'Rp150.000'),
    ];

    int selected = 0;
    final textTheme = Theme.of(context).textTheme;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          margin: const EdgeInsets.all(AppDimens.xl),
          padding: const EdgeInsets.all(AppDimens.lg),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: StatefulBuilder(
            builder: (context, setModal) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Pilih Paket Langganan',
                    textAlign: TextAlign.center,
                    style: textTheme.titleMedium?.copyWith(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 16),

                  ...List.generate(plans.length, (i) {
                    final sel = selected == i;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Material(
                        color: AppColors.inputFill,
                        borderRadius: BorderRadius.circular(14),
                        child: InkWell(
                          onTap: () =>
                              setModal(() => selected = i),
                          borderRadius:
                              BorderRadius.circular(14),
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(14),
                              border: Border.all(
                                color: sel
                                    ? AppColors.primaryNavy
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  plans[i].$1,
                                  style: textTheme.titleMedium
                                      ?.copyWith(fontSize: 14),
                                ),
                                const Spacer(),
                                Text(
                                  plans[i].$2,
                                  style: textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 8),

                  PrimaryButton(
                    label: 'Konfirmasi',
                    onPressed: () {
                      setState(() {
                        _planLabel = plans[selected].$1;
                        _planPrice = plans[selected].$2;
                      });
                      Navigator.pop(ctx);
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.profileNavy,

      // ================= APP BAR =================
      appBar: NavyBackAppBar(
        title: 'WushLaundry PRO',
        onBack: () => Navigator.pop(context),
      ),

      body: Column(
        children: [
          Expanded(
            child: RoundedWhitePanel(
              topRadius: AppDimens.radiusXl,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimens.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _miniFeature(
                            icon: Icons.workspace_premium,
                            title: 'PRO',
                            subtitle: 'Diskon 10% setiap hari',
                            textTheme: textTheme,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _miniFeature(
                            icon:
                                Icons.local_shipping_outlined,
                            title: 'FREE',
                            subtitle:
                                'Gratis ongkir tanpa batas',
                            textTheme: textTheme,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppDimens.xl),

                    Text(
                      'Keuntungan:',
                      style: textTheme.titleMedium
                          ?.copyWith(
                        color: AppColors.actionBlue,
                      ),
                    ),
                    const SizedBox(height: 12),

                    _benefit(
                      Icons.workspace_premium,
                      'Diskon 10% setiap hari!',
                      'Potongan belanja khusus Member PRO',
                      textTheme,
                    ),
                    _benefit(
                      Icons.local_shipping_outlined,
                      'Free Delivery tanpa batas',
                      'Jadikan pesananmu selalu free delivery',
                      textTheme,
                    ),
                    _benefit(
                      Icons.verified_outlined,
                      'Pelanggan Prioritas',
                      'Pesananmu menjadi prioritas kurir',
                      textTheme,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Masa berlaku: 6 bulan setelah pembelian',
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ================= BOTTOM BAR =================
          Container(
            color: AppColors.white,
            padding: EdgeInsets.fromLTRB(
              AppDimens.xl,
              12,
              AppDimens.xl,
              MediaQuery.paddingOf(context).bottom + 12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      OutlinedButton.icon(
                        onPressed: _openPlanPicker,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 20,
                        ),
                        label: Text(_planLabel),
                        style:
                            OutlinedButton.styleFrom(
                          foregroundColor:
                              AppColors.headerNavy,
                          side: const BorderSide(
                            color: AppColors.borderLight,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Total: $_planPrice',
                        style: textTheme.titleMedium
                            ?.copyWith(
                          color:
                              AppColors.actionBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 140,
                  height: AppDimens.buttonHeight,
                  child: PrimaryButton(
                    label: 'Berlangganan',
                    onPressed: () =>
                        _successPopup(context),
                    expanded: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniFeature({
    required IconData icon,
    required String title,
    required String subtitle,
    required TextTheme textTheme,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.actionBlue),
          const SizedBox(height: 6),
          Text(
            title,
            style: textTheme.titleMedium
                ?.copyWith(fontSize: 13),
          ),
          Text(
            subtitle,
            style:
                textTheme.bodySmall?.copyWith(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _benefit(
    IconData icon,
    String title,
    String subtitle,
    TextTheme textTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.actionBlue,
            size: 26,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleMedium
                      ?.copyWith(fontSize: 14),
                ),
                Text(
                  subtitle,
                  style: textTheme.bodyMedium
                      ?.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _successPopup(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColors.profileNavy,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Text(
                  'WushLaundry PRO',
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppDimens.xl),
                child: Column(
                  children: [
                    Text(
                      'Kamu telah menjadi Member PRO',
                      textAlign: TextAlign.center,
                      style: textTheme.titleMedium
                          ?.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Dapatkan diskon dan ongkir gratis setiap hari',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      label: 'Kembali',
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}