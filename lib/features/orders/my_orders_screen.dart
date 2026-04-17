import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';

import '../../core/widgets/indicators.dart';
import '../../core/widgets/cards.dart';
import '../../core/widgets/rounded_white_panel.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({
    super.key,
    this.loggedIn = false,
    this.hasOrders = false,
  });

  final bool loggedIn;
  final bool hasOrders;

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ColoredBox(
      color: AppColors.ordersNavy,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: AppDimens.sm),
            Text(
              'Pesanan Saya',
              style: textTheme.titleLarge?.copyWith(
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: AppDimens.sm),

            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: AppDimens.lg),
                child: RoundedWhitePanel(
                  topRadius: 40,
                  padding: const EdgeInsets.all(AppDimens.xl),
                  child: Column(
                    children: [
                      OrderStatusSegmentedBar(
                        selectedIndex: _tab,
                        onChanged: (i) =>
                            setState(() => _tab = i),
                      ),
                      const SizedBox(height: AppDimens.lg),
                      Expanded(child: _buildContent()),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= CONTENT =================
  Widget _buildContent() {
    if (!widget.loggedIn || !widget.hasOrders) {
      return const _EmptyOrdersState();
    }

    if (_tab == 2) {
      return const _DummyHistory();
    }

    return const _EmptyOrdersState();
  }
}

/// ================= EMPTY STATE =================
class _EmptyOrdersState extends StatelessWidget {
  const _EmptyOrdersState();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimens.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.receipt_long_outlined,
              size: 72,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: AppDimens.md),
            Text(
              'Belum ada pesanan',
              style: textTheme.titleMedium?.copyWith(
                color: AppColors.textDark,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimens.sm),
            Text(
              'Pesanan kamu akan tampil di sini setelah melakukan order.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= RIWAYAT (DUMMY) =================
class _DummyHistory extends StatelessWidget {
  const _DummyHistory();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        PesananOrderCard(
          customerName: 'Aurora Emilia',
          orderId: 'No. Pesanan 001016',
          dateLabel: '16 Juli 2025',
          serviceTitle: 'Cuci Setrika',
          priceLabel: 'Rp28.000/plastik',
          qty: 2,
          shippingLabel: 'Biaya Pengiriman: Rp5.000',
          totalLabel: 'Rp61.000',
        ),
        SizedBox(height: AppDimens.md),
        PesananOrderCard(
          customerName: 'Aurora Emilia',
          orderId: 'No. Pesanan 000998',
          dateLabel: '12 Juli 2025',
          serviceTitle: 'Cuci Regular',
          priceLabel: 'Rp20.000/plastik',
          qty: 1,
          shippingLabel: 'Biaya Pengiriman: Rp5.000',
          totalLabel: 'Rp25.000',
        ),
      ],
    );
  }
} 