import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';

import '../../core/widgets/navigation.dart';
import '../../core/widgets/rounded_white_panel.dart';
import '../../core/widgets/indicators.dart';
import '../../core/widgets/cards.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.headerNavy,

      // ================= APP BAR =================
      appBar: NavyBackAppBar(
        title: 'Detail Pesanan',
        onBack: () => Navigator.pop(context),
      ),

      // ================= BODY =================
      body: Column(
        children: [
          const SizedBox(height: AppDimens.sm),
          Expanded(
            child: RoundedWhitePanel(
              topRadius: AppDimens.sheetTopRadius,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimens.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pesanan kamu sedang dicuci',
                      style: textTheme.titleMedium?.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: AppDimens.sm),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.successBg,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Diproses',
                          style: textTheme.bodySmall?.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: AppDimens.lg),

                    // ================= STEP PROGRESS =================
                    const OrderStepProgressBar(activeIndex: 1),

                    const SizedBox(height: AppDimens.lg),

                    // ================= MINI MAP =================
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            const ColoredBox(
                              color: Color(0xFFE8EEF5),
                            ),
                            CustomPaint(
                              painter: _MiniMapPainter(),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: AppDimens.lg),

                    // ================= ADDRESS TIMELINE =================
                    _timeline(textTheme),

                    const SizedBox(height: AppDimens.xl),

                    // ================= SERVICE SUMMARY =================
                    const ServiceSummaryTile(
                      title: 'Cuci Regular',
                      priceLabel: 'Rp 20.000 / Plastik',
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

  // ================= TIMELINE =================
  Widget _timeline(TextTheme textTheme) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: AppColors.actionBlue,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 2,
                  height: 40,
                  color: AppColors.borderLight,
                ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(width: AppDimens.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Titik Penjemputan',
                    style: textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Jl. Kenanga No. 10',
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppDimens.lg),
                  Text(
                    'Titik Pengiriman',
                    style: textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Jln. Matahari No. 456',
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ================= MINI MAP PAINTER =================
class _MiniMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final route = Paint()
      ..color = AppColors.actionBlue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.72)
      ..quadraticBezierTo(
        size.width * 0.45,
        size.height * 0.35,
        size.width * 0.78,
        size.height * 0.48,
      );

    canvas.drawPath(path, route);

    final pin = Paint()..color = Colors.redAccent;
    canvas.drawCircle(
      Offset(size.width * 0.22, size.height * 0.72),
      6,
      pin,
    );
    canvas.drawCircle(
      Offset(size.width * 0.78, size.height * 0.48),
      6,
      pin,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}