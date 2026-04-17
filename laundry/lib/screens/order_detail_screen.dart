import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import '../widgets/navy_app_bar.dart';
import '../widgets/rounded_white_panel.dart';
import '../widgets/service_summary_tile.dart';
import '../widgets/step_progress_bar.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.headerNavy,
      appBar: NavyBackAppBar(
        title: 'Detail Pesanan',
        onBack: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: RoundedWhitePanel(
              topRadius: AppSpacing.sheetTopRadius,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pesanan kamu sedang dicuci', style: AppTextStyles.sectionTitle.copyWith(fontSize: 15)),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.successBg,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Diproses',
                          style: AppTextStyles.caption.copyWith(color: AppColors.success, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const OrderStepProgressBar(activeIndex: 1),
                    const SizedBox(height: AppSpacing.lg),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            const ColoredBox(color: Color(0xFFE8EEF5)),
                            CustomPaint(painter: _MiniMapPainter()),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _timeline(),
                    const SizedBox(height: AppSpacing.xl),
                    const ServiceSummaryTile(
                      title: 'Cuci regular',
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

  Widget _timeline() {
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
                  decoration: const BoxDecoration(color: AppColors.actionBlue, shape: BoxShape.circle),
                ),
                Container(width: 2, height: 40, color: AppColors.borderLight),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Titik Penjemputan', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700)),
                  Text('Jl. Kenanga No. 10', style: AppTextStyles.bodyMuted),
                  const SizedBox(height: 20),
                  Text('Titik Pengiriman', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700)),
                  Text('Jln. Matahari no. 456', style: AppTextStyles.bodyMuted),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

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
      ..quadraticBezierTo(size.width * 0.45, size.height * 0.35, size.width * 0.78, size.height * 0.48);
    canvas.drawPath(path, route);
    final pin = Paint()..color = Colors.redAccent;
    canvas.drawCircle(Offset(size.width * 0.22, size.height * 0.72), 6, pin);
    canvas.drawCircle(Offset(size.width * 0.78, size.height * 0.48), 6, pin);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
