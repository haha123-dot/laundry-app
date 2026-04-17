import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import 'info_kv_row.dart';
import 'outline_navy_button.dart';
import 'primary_button.dart';

void showLoginModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    isDismissible: true, // ✅ tap di mana saja bisa tutup
    enableDrag: true,    // ✅ swipe ke bawah
    backgroundColor: Colors.transparent,
    builder: (_) => const _LoginModalCard(),
  );
}

class _LoginModalCard extends StatelessWidget {
  const _LoginModalCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.xl,
        right: AppSpacing.xl,
        bottom: MediaQuery.paddingOf(context).bottom + AppSpacing.xl,
      ),
      child: Center(
        child: Material(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // ====== TOMBOL X ======
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  color: AppColors.textMuted,
                  onPressed: () {
                    Navigator.pop(context); // ✅ BALIK KE HOME
                  },
                ),
              ),

              // ====== ISI MODAL ======
              Padding(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      'Masuk ke Akun Anda',
                      textAlign: TextAlign.center,
                      style:
                          AppTextStyles.sectionTitle.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Anda harus masuk terlebih dahulu untuk melanjutkan tindakan ini.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMuted,
                    ),
                    const SizedBox(height: 22),

                    PrimaryButton(
                      label: 'Masuk dengan Email',
                      leading: const Icon(
                        Icons.email_outlined,
                        color: AppColors.white,
                        size: 22,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/login');
                      },
                    ),

                    const SizedBox(height: 12),

                    OutlineNavyButton(
                      label: 'Masuk dengan Google',
                      leading: _googleMini(),
                      onPressed: () {},
                    ),

                    const SizedBox(height: 16),
                    const PaymentDividerLabel(label: 'ATAU'),
                    const SizedBox(height: 16),

                    PrimaryButton(
                      label: 'Sign Up',
                      backgroundColor: AppColors.accentBlue,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/register');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _googleMini() {
    return Container(
      width: 22,
      height: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Text(
        'G',
        style: AppTextStyles.sectionTitle.copyWith(
          fontSize: 13,
          color: Colors.redAccent,
        ),
      ),
    );
  }
}