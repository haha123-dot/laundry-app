import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import '../widgets/payment_method_tile.dart';

class PaymentMethodScreen
    extends
        StatelessWidget {
  const PaymentMethodScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: AppColors.pageBg,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Pilih Metode Pembayaran',
          style: AppTextStyles.screenTitleNavy,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.headerNavy,
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(
              AppSpacing.xl,
            ),
            children: [
              PaymentMethodTile(
                title: 'DANA',
                connected: true,
                leading: const WalletLogoBox(
                  label: 'D',
                  color: Color(
                    0xFF118EEA,
                  ),
                ),
                onTap: () => Navigator.pushNamed(
                  context,
                  '/pin',
                  arguments: 'DANA',
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              PaymentMethodTile(
                title: 'OVO',
                connected: true,
                leading: const WalletLogoBox(
                  label: 'O',
                  color: Color(
                    0xFF6B2C91,
                  ),
                ),
                onTap: () => Navigator.pushNamed(
                  context,
                  '/pin',
                  arguments: 'OVO',
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              const PaymentMethodTile(
                title: 'BCA',
                leading: WalletLogoBox(
                  label: 'B',
                  color: AppColors.headerNavy,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              const PaymentMethodTile(
                title: 'BNI',
                leading: WalletLogoBox(
                  label: 'N',
                  color: Color(
                    0xFF00529C,
                  ),
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              const PaymentMethodTile(
                title: 'Mandiri',
                leading: WalletLogoBox(
                  label: 'M',
                  color: Color(
                    0xFFFF6B00,
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            right: 16,
            bottom:
                MediaQuery.paddingOf(
                  context,
                ).bottom +
                16,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(
                  24,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                      0.12,
                    ),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Row(
                children: [
                  _avatar(
                    'N',
                  ),
                  const SizedBox(
                    width: -6,
                  ),
                  _avatar(
                    'A',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatar(
    String l,
  ) {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.accentBlue.withOpacity(
          0.2,
        ),
        border: Border.all(
          color: AppColors.white,
          width: 2,
        ),
      ),
      child: Text(
        l,
        style: AppTextStyles.sectionTitle.copyWith(
          fontSize: 13,
        ),
      ),
    );
  }
}
