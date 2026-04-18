import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wushlaundry/constants/app_colors.dart';
import 'package:wushlaundry/constants/app_spacing.dart';
import 'package:wushlaundry/constants/app_text_styles.dart';
import 'package:wushlaundry/widgets/curved_navy_header.dart';
import 'package:wushlaundry/widgets/labeled_text_field.dart';
import 'package:wushlaundry/widgets/primary_button.dart';

class LoginScreen
    extends
        StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<
    LoginScreen
  >
  createState() => _LoginScreenState();
}

class _LoginScreenState
    extends
        State<
          LoginScreen
        > {
  bool _obscure = true;
  bool _staySignedIn = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<
    void
  >
  handleLogin() async {
    final prefs = await SharedPreferences.getInstance();

    String email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            "Email tidak boleh kosong",
          ),
        ),
      );
      return;
    }

    String namaUser = email.split(
      '@',
    )[0];

    await prefs.setBool(
      'isLoggedIn',
      true,
    );
    await prefs.setString(
      'userName',
      namaUser,
    );
    await prefs.setString(
      'userEmail',
      email,
    );

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/main',
      (
        route,
      ) => false,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: AppColors.pageBg,
      body: Column(
        children: [
          const CurvedNavyHeader(
            heightFraction: 0.35,
            subtitle: 'Masuk untuk menikmati layanan laundry yang lebih praktis',
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.lg,
              ),
              child: Container(
                padding: const EdgeInsets.all(
                  AppSpacing.xl,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        0.05,
                      ),
                      blurRadius: 12,
                      offset: const Offset(
                        0,
                        6,
                      ),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /// EMAIL
                    LabeledTextField(
                      label: 'Email',
                      hint: 'Masukkan Email',
                      prefixIcon: Icons.email_outlined,
                      controller: emailController,
                    ),

                    const SizedBox(
                      height: AppSpacing.lg,
                    ),

                    /// PASSWORD
                    LabeledTextField(
                      label: 'Password',
                      hint: 'Masukkan Password',
                      prefixIcon: Icons.lock_outline_rounded,
                      controller: passwordController,
                      obscure: _obscure,
                      suffix: IconButton(
                        onPressed: () => setState(
                          () => _obscure = !_obscure,
                        ),
                        icon: Icon(
                          _obscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    /// OPTIONS
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                          onTap: () => setState(
                            () => _staySignedIn = !_staySignedIn,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _staySignedIn
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                                color: _staySignedIn
                                    ? AppColors.primaryNavy
                                    : AppColors.textSecondary,
                                size: 22,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Tetap masuk',
                                style: AppTextStyles.body.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Lupa password',
                            style: AppTextStyles.link,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    /// LOGIN BUTTON
                    PrimaryButton(
                      label: 'Masuk',
                      onPressed: handleLogin,
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    /// REGISTER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum punya akun? ',
                          style: AppTextStyles.bodyMuted,
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushReplacementNamed(
                            context,
                            '/register',
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Daftar',
                            style: AppTextStyles.link,
                          ),
                        ),
                      ],
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
}
