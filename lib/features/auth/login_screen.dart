import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/widgets/buttons.dart';
import '../../core/widgets/forms.dart';
import '../../core/widgets/navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscure = true;
  bool _staySignedIn = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> handleLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email tidak boleh kosong'),
        ),
      );
      return;
    }

    final userName = email.split('@').first;

    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userName', userName);
    await prefs.setString('userEmail', email);

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/main',
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                horizontal: AppDimens.xl,
                vertical: AppDimens.lg,
              ),
              child: Container(
                padding: const EdgeInsets.all(AppDimens.xl),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(
                    AppDimens.radiusXl,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
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

                    const SizedBox(height: AppDimens.lg),

                    /// PASSWORD
                    LabeledTextField(
                      label: 'Password',
                      hint: 'Masukkan Password',
                      prefixIcon: Icons.lock_outline_rounded,
                      controller: passwordController,
                      obscure: _obscure,
                      suffix: IconButton(
                        onPressed: () =>
                            setState(() => _obscure = !_obscure),
                        icon: Icon(
                          _obscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),

                    const SizedBox(height: AppDimens.md),

                    /// OPTIONS
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(
                            AppDimens.radiusMd,
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
                              const SizedBox(width: AppDimens.sm),
                              Text(
                                'Tetap masuk',
                                style: textTheme.bodyMedium?.copyWith(
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
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.linkBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppDimens.xl),

                    /// LOGIN BUTTON
                    PrimaryButton(
                      label: 'Masuk',
                      onPressed: handleLogin,
                    ),

                    const SizedBox(height: AppDimens.lg),

                    /// DIVIDER
                    Center(
                      child: Text(
                        'ATAU',
                        style: textTheme.bodySmall,
                      ),
                    ),

                    const SizedBox(height: AppDimens.lg),

                    /// GOOGLE LOGIN
                    OutlineNavyButton(
                      label: 'Masuk dengan Google',
                      onPressed: () async {
                        final prefs =
                            await SharedPreferences.getInstance();

                        await prefs.setBool('isLoggedIn', true);
                        await prefs.setString(
                            'userName', 'Google User');
                        await prefs.setString(
                            'userEmail', 'user@gmail.com');

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/main',
                          (_) => false,
                        );
                      },
                    ),

                    const SizedBox(height: AppDimens.xl),

                    /// REGISTER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum punya akun? ',
                          style: textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.pushReplacementNamed(
                            context,
                            '/register',
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Daftar',
                            style: textTheme.labelLarge?.copyWith(
                              color: AppColors.linkBlue,
                            ),
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