import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wushlaundry/widgets/curved_navy_header.dart';
import 'package:wushlaundry/widgets/labeled_text_field.dart';
import 'package:wushlaundry/widgets/primary_button.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';

class RegisterScreen
    extends
        StatefulWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  State<
    RegisterScreen
  >
  createState() => _RegisterScreenState();
}

class _RegisterScreenState
    extends
        State<
          RegisterScreen
        > {
  bool _obscure1 = true;
  bool _obscure2 = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<
    void
  >
  handleRegister() async {
    final prefs = await SharedPreferences.getInstance();

    String name = nameController.text.trim();
    String email = emailController.text.trim();

    if (name.isEmpty ||
        email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            "Nama & Email wajib diisi",
          ),
        ),
      );
      return;
    }

    await prefs.setBool(
      'isLoggedIn',
      true,
    );
    await prefs.setString(
      'userName',
      name,
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
            heightFraction: 0.32,
            subtitle: 'Daftar untuk pengalaman laundry yang lebih personal dan praktis',
          ),

          Expanded(
            child: Transform.translate(
              offset: const Offset(
                0,
                -28,
              ),

              // ================= SAME SCROLL AS HOME =================
              child: ScrollConfiguration(
                behavior: const _NoOverscrollBehavior(),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LabeledTextField(
                        label: 'Nama Lengkap',
                        hint: 'Masukkan Nama Lengkap',
                        prefixIcon: Icons.person_outline_rounded,
                        controller: nameController,
                      ),

                      const SizedBox(
                        height: AppSpacing.lg,
                      ),

                      LabeledTextField(
                        label: 'Email',
                        hint: 'Masukkan Email',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                      ),

                      const SizedBox(
                        height: AppSpacing.lg,
                      ),

                      LabeledTextField(
                        label: 'Alamat',
                        hint: 'Masukkan Alamat',
                        prefixIcon: Icons.location_on_outlined,
                        maxLines: 3,
                      ),

                      const SizedBox(
                        height: AppSpacing.lg,
                      ),

                      _phoneField(),

                      const SizedBox(
                        height: AppSpacing.lg,
                      ),

                      LabeledTextField(
                        label: 'Password',
                        hint: 'Masukkan Password',
                        prefixIcon: Icons.lock_outline_rounded,
                        obscure: _obscure1,
                        suffix: IconButton(
                          onPressed: () => setState(
                            () => _obscure1 = !_obscure1,
                          ),
                          icon: Icon(
                            _obscure1
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: AppSpacing.lg,
                      ),

                      LabeledTextField(
                        label: 'Konfirmasi Password',
                        hint: 'Masukkan Konfirmasi Password',
                        prefixIcon: Icons.lock_outline_rounded,
                        obscure: _obscure2,
                        suffix: IconButton(
                          onPressed: () => setState(
                            () => _obscure2 = !_obscure2,
                          ),
                          icon: Icon(
                            _obscure2
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: AppSpacing.xxl,
                      ),

                      PrimaryButton(
                        label: 'Daftar',
                        onPressed: handleRegister,
                      ),

                      const SizedBox(
                        height: AppSpacing.xxl,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sudah punya akun? ',
                            style: AppTextStyles.bodyMuted,
                          ),
                          TextButton(
                            onPressed: () => Navigator.pushReplacementNamed(
                              context,
                              '/login',
                            ),
                            child: Text(
                              'Masuk',
                              style: AppTextStyles.link,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 32,
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

  Widget _phoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'No. HP',
          style: AppTextStyles.sectionTitle.copyWith(
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          keyboardType: TextInputType.phone,
          style: AppTextStyles.body,
          decoration: InputDecoration(
            hintText: '123 4567 891',
            hintStyle: AppTextStyles.bodyMuted,
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 4,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '🇮🇩',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.textSecondary,
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: AppColors.borderLight,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '+ 62',
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppSpacing.inputRadius,
              ),
              borderSide: const BorderSide(
                color: AppColors.borderLight,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppSpacing.inputRadius,
              ),
              borderSide: const BorderSide(
                color: AppColors.borderLight,
                width: 1.2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppSpacing.inputRadius,
              ),
              borderSide: const BorderSide(
                color: AppColors.primaryNavy,
                width: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ================= SAME AS HOME =================
class _NoOverscrollBehavior
    extends
        ScrollBehavior {
  const _NoOverscrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(
    BuildContext context,
  ) {
    return const ClampingScrollPhysics();
  }
}
