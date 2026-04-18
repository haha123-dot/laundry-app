import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import '../widgets/navy_app_bar.dart';
import '../widgets/rounded_white_panel.dart';
import '../widgets/step_progress_bar.dart';

// 🔥 TAMBAHAN IMPORT (WAJIB)
import '../screens/main_shell_screen.dart';

class OrderDetailScreen
    extends
        StatelessWidget {
  const OrderDetailScreen({
    super.key,
  });

  int _calculateDurationMinutes(
    String pickup,
    String delivery,
  ) {
    try {
      final p = DateTime.parse(
        pickup,
      );
      final d = DateTime.parse(
        delivery,
      );
      return d
          .difference(
            p,
          )
          .inMinutes;
    } catch (
      e
    ) {
      return 120;
    }
  }

  String _formatRupiah(
    int value,
  ) {
    final s = value.toString();
    final buffer = StringBuffer();

    int count = 0;
    for (
      int i =
          s.length -
          1;
      i >=
          0;
      i--
    ) {
      buffer.write(
        s[i],
      );
      count++;
      if (count %
                  3 ==
              0 &&
          i !=
              0) {
        buffer.write(
          '.',
        );
      }
    }

    return buffer
        .toString()
        .split(
          '',
        )
        .reversed
        .join();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final args =
        ModalRoute.of(
              context,
            )?.settings.arguments
            as Map? ??
        {};

    final int plasticCount =
        args['qty'] ??
        1;
    final String orderId = '001156';

    final String pickupTimeText =
        args['pickupTime'] ??
        '-';
    final String deliveryTimeText =
        args['deliveryTime'] ??
        '-';

    final String pickupAddress =
        args['address'] ??
        'Alamat belum diisi';
    final String deliveryAddress =
        args['deliveryAddress'] ??
        pickupAddress;

    final String serviceName =
        args['service'] ??
        'Cuci Regular';

    final int serviceFee =
        args['serviceFee'] ??
        0;
    final int deliveryFee =
        args['deliveryFee'] ??
        0;
    final int total =
        args['total'] ??
        0;

    final int durationMinutes = _calculateDurationMinutes(
      pickupTimeText,
      deliveryTimeText,
    );

    final String durationText =
        durationMinutes >=
            60
        ? '${(durationMinutes / 60).round()} jam'
        : '$durationMinutes menit';

    return Scaffold(
      backgroundColor: AppColors.headerNavy,
      appBar: NavyBackAppBar(
        title: 'Detail Pesanan',

        // 🔥 FIX FINAL (PASTI WORK)
        onBack: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder:
                  (
                    _,
                  ) => const MainShellScreen(),
            ),
            (
              route,
            ) => false,
          );
        },
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: RoundedWhitePanel(
              topRadius: 40,
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.xl,
                AppSpacing.xl,
                8,
              ),
              child:
                  NotificationListener<
                    OverscrollIndicatorNotification
                  >(
                    onNotification:
                        (
                          overscroll,
                        ) {
                          overscroll.disallowIndicator();
                          return true;
                        },
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _box(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Pesanan kamu akan segera diambil',
                                        style: AppTextStyles.sectionTitle.copyWith(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.successBg,
                                        borderRadius: BorderRadius.circular(
                                          20,
                                        ),
                                      ),
                                      child: Text(
                                        'Diproses',
                                        style: AppTextStyles.caption.copyWith(
                                          color: AppColors.success,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Center(
                                  child: Text(
                                    'Pesanan $orderId • $plasticCount plastik • selesai dalam $durationText',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.caption.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const OrderStepProgressBar(
                                  activeIndex: 0,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    16,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio:
                                        16 /
                                        9,
                                    child: Image.asset(
                                      'assets/images/map_dummy.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      'Titik Penjemputan',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  pickupAddress,
                                  style: AppTextStyles.body,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: List.generate(
                                    3,
                                    (
                                      index,
                                    ) => const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 1,
                                      ),
                                      child: Text(
                                        '•',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          height: 0.7,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.green,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      'Titik Pengantaran',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  deliveryAddress,
                                  style: AppTextStyles.bodyMuted,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          _box(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ),
                                      child: Container(
                                        width: 64,
                                        height: 64,
                                        color: const Color(
                                          0xFFECECEC,
                                        ),
                                        child: const Icon(
                                          Icons.local_laundry_service,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            serviceName,
                                            style: AppTextStyles.sectionTitle,
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            'Rp 20.000 / plastik',
                                            style: AppTextStyles.bodyMuted,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Divider(),
                                _row(
                                  'Waktu Pengambilan',
                                  pickupTimeText,
                                ),
                                const Divider(),
                                _row(
                                  'Waktu Pengiriman',
                                  deliveryTimeText,
                                ),
                                const Divider(),
                                _row(
                                  'Alamat Pengiriman',
                                  deliveryAddress,
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Detail Pembayaran',
                                  style: AppTextStyles.sectionTitle,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                _row(
                                  'Biaya Layanan',
                                  'Rp ${_formatRupiah(serviceFee)}',
                                ),
                                _row(
                                  'Biaya Pengiriman',
                                  'Rp ${_formatRupiah(deliveryFee)}',
                                ),
                                _row(
                                  'Kode Promo',
                                  '-',
                                ),
                                const Divider(),
                                _row(
                                  'Total Pembayaran',
                                  'Rp ${_formatRupiah(total)}',
                                  bold: true,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _box({
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(
        16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          16,
        ),
        border: Border.all(
          color: AppColors.borderLight,
        ),
      ),
      child: child,
    );
  }

  Widget _row(
    String title,
    String value, {
    bool bold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: bold
                  ? AppTextStyles.sectionTitle
                  : AppTextStyles.body,
            ),
          ),
          Text(
            value,
            style: bold
                ? AppTextStyles.sectionTitle
                : AppTextStyles.body,
          ),
        ],
      ),
    );
  }
}
