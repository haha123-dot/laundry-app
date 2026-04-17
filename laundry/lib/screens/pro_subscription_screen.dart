import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import '../widgets/navy_app_bar.dart';
import '../widgets/primary_button.dart';
import '../widgets/rounded_white_panel.dart';

class ProSubscriptionScreen
    extends
        StatefulWidget {
  const ProSubscriptionScreen({
    super.key,
  });

  @override
  State<
    ProSubscriptionScreen
  >
  createState() => _ProSubscriptionScreenState();
}

class _ProSubscriptionScreenState
    extends
        State<
          ProSubscriptionScreen
        > {
  String _planLabel = '6 Bulan';
  String _planPrice = 'Rp210.000';

  final List<
    (
      String,
      String,
    )
  >
  _plans = const [
    (
      '6 Bulan',
      'Rp210.000',
    ),
    (
      '3 Bulan',
      'Rp175.000',
    ),
    (
      '1 Bulan',
      'Rp150.000',
    ),
  ];

  int _getSelectedIndex() {
    final index = _plans.indexWhere(
      (
        e,
      ) =>
          e.$1 ==
          _planLabel,
    );
    return index ==
            -1
        ? 0
        : index;
  }

  void _openPlanPicker() {
    int selected = _getSelectedIndex();

    showModalBottomSheet<
      void
    >(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (
            ctx,
          ) {
            return StatefulBuilder(
              builder:
                  (
                    context,
                    setModal,
                  ) {
                    return Container(
                      margin: const EdgeInsets.all(
                        AppSpacing.xl,
                      ),
                      padding: const EdgeInsets.all(
                        AppSpacing.lg,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        border: Border.all(
                          color: AppColors.borderLight,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Pilih Paket Langganan',
                            style: AppTextStyles.sectionTitle.copyWith(
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),

                          ...List.generate(
                            _plans.length,
                            (
                              i,
                            ) {
                              final sel =
                                  selected ==
                                  i;

                              return GestureDetector(
                                onTap: () => setModal(
                                  () => selected = i,
                                ),
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.inputFill,
                                    borderRadius: BorderRadius.circular(
                                      14,
                                    ),
                                    border: Border.all(
                                      color: sel
                                          ? AppColors.actionBlue
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        _plans[i].$1,
                                        style: AppTextStyles.sectionTitle.copyWith(
                                          fontSize: 14,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        _plans[i].$2,
                                        style: AppTextStyles.body,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          PrimaryButton(
                            label: 'Konfirmasi',
                            onPressed: () {
                              setState(
                                () {
                                  _planLabel = _plans[selected].$1;
                                  _planPrice = _plans[selected].$2;
                                },
                              );
                              Navigator.pop(
                                ctx,
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
            );
          },
    );
  }

  String _getDurationFromLabel() {
    if (_planLabel.contains(
      '6',
    ))
      return '6 bulan setelah pembelian';
    if (_planLabel.contains(
      '3',
    ))
      return '3 bulan setelah pembelian';
    if (_planLabel.contains(
      '1',
    ))
      return '1 bulan setelah pembelian';
    return '';
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: AppColors.profileNavy,
      appBar: NavyBackAppBar(
        title: 'WushLaundry PRO',
        onBack: () => Navigator.pop(
          context,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: RoundedWhitePanel(
              topRadius: 28,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(
                  AppSpacing.xl,
                ),
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
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: _miniFeature(
                            icon: Icons.local_shipping_outlined,
                            title: 'FREE',
                            subtitle: 'Gratis ongkir tanpa batas',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    Text(
                      'Keuntungan:',
                      style: AppTextStyles.sectionTitle.copyWith(
                        color: AppColors.actionBlue,
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    _benefit(
                      Icons.workspace_premium,
                      'Diskon 10% setiap hari!',
                      'Potongan belanja Khusus Member PRO',
                    ),
                    _benefit(
                      Icons.local_shipping_outlined,
                      'Free Delivery tanpa batas',
                      'Jadikan pesananmu selalu free delivery',
                    ),
                    _benefit(
                      Icons.verified_outlined,
                      'Pelanggan Prioritas',
                      'Pesananmu akan menjadi prioritas kurir',
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    Text(
                      'Masa berlaku: ${_getDurationFromLabel()}',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            color: AppColors.white,
            padding: EdgeInsets.fromLTRB(
              AppSpacing.xl,
              12,
              AppSpacing.xl,
              MediaQuery.paddingOf(
                    context,
                  ).bottom +
                  12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OutlinedButton.icon(
                        onPressed: _openPlanPicker,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                        ),
                        label: Text(
                          _planLabel,
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.headerNavy,
                          side: const BorderSide(
                            color: AppColors.borderLight,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Total: $_planPrice',
                        style: AppTextStyles.sectionTitle.copyWith(
                          color: AppColors.actionBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                SizedBox(
                  width: 140,
                  height: 48,
                  child: PrimaryButton(
                    label: 'Berlangganan',
                    onPressed: () => _successPopup(
                      context,
                    ),
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

  /// ================= MINI FEATURE =================
  Widget _miniFeature({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return SizedBox(
      height: 100,
      child: Container(
        padding: const EdgeInsets.all(
          12,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(
            14,
          ),
          border: Border.all(
            color: AppColors.borderLight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.actionBlue,
              size: 22,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.sectionTitle.copyWith(
                fontSize: 13,
              ),
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _benefit(
    IconData icon,
    String t,
    String s,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 14,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.actionBlue,
            size: 26,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t,
                  style: AppTextStyles.sectionTitle.copyWith(
                    fontSize: 14,
                  ),
                ),
                Text(
                  s,
                  style: AppTextStyles.bodyMuted.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _successPopup(
    BuildContext context,
  ) {
    showDialog<
      void
    >(
      context: context,
      barrierDismissible: false,
      builder:
          (
            ctx,
          ) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(
                      16,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.profileNavy,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Text(
                      'WushLaundry PRO',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.screenTitleWhite,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                      AppSpacing.xl,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Kamu telah menjadi Member PRO',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.sectionTitle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Dapatkan diskon dan ongkir gratis setiap hari',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyMuted,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        PrimaryButton(
                          label: 'Kembali',
                          onPressed: () {
                            Navigator.pop(
                              ctx,
                            );
                            Navigator.pop(
                              context,
                            );
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
