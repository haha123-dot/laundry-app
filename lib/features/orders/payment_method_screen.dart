import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';

import '../../core/widgets/cards.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.pageBg,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Pilih Metode Pembayaran',
          style: textTheme.titleLarge?.copyWith(
            color: AppColors.headerNavy,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.headerNavy,
        ),
      ),

      // ================= BODY =================
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(AppDimens.xl),
            children: [
              InkWell(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/pin',
                  arguments: 'DANA',
                ),
                child: const PaymentMethodTile(
                  title: 'DANA',
                  connected: true,
                  leading: WalletLogoBox(
                    label: 'D',
                    color: Color(0xFF118EEA),
                  ),
                ),
              ),
              const SizedBox(height: AppDimens.md),
              InkWell(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/pin',
                  arguments: 'OVO',
                ),
                child: const PaymentMethodTile(
                  title: 'OVO',
                  connected: true,
                  leading: WalletLogoBox(
                    label: 'O',
                    color: Color(0xFF6B2C91),
                  ),
                ),
              ),
              const SizedBox(height: AppDimens.md),
              const PaymentMethodTile(
                title: 'BCA',
                leading: WalletLogoBox(
                  label: 'B',
                  color: AppColors.headerNavy,
                ),
              ),
              const SizedBox(height: AppDimens.md),
              const PaymentMethodTile(
                title: 'BNI',
                leading: WalletLogoBox(
                  label: 'N',
                  color: Color(0xFF00529C),
                ),
              ),
              const SizedBox(height: AppDimens.md),
              const PaymentMethodTile(
                title: 'Mandiri',
                leading: WalletLogoBox(
                  label: 'M',
                  color: Color(0xFFFF6B00),
                ),
              ),
            ],
          ),

          // ================= FLOATING AVATAR =================
          Positioned(
            right: AppDimens.md,
            bottom: MediaQuery.paddingOf(context).bottom +
                AppDimens.md,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Row(
                children: const [
                  _Avatar('N'),
                  SizedBox(width: -6),
                  _Avatar('A'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= AVATAR =================
class _Avatar extends StatelessWidget {
  const _Avatar(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.accentBlue.withOpacity(0.2),
        border: Border.all(
          color: AppColors.white,
          width: 2,
        ),
      ),
      child: Text(
        label,
        style: textTheme.titleMedium?.copyWith(
          fontSize: 13,
          color: AppColors.headerNavy,
        ),
      ),
    );
  }
}