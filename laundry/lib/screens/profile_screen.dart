import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wushlaundry/widgets/primary_button.dart';
import 'package:wushlaundry/widgets/rounded_white_panel.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';

class ProfileScreen
    extends
        StatefulWidget {
  const ProfileScreen({
    super.key,
    this.embedded = false,
  });

  final bool embedded;

  @override
  State<
    ProfileScreen
  >
  createState() => _ProfileScreenState();
}

class _ProfileScreenState
    extends
        State<
          ProfileScreen
        > {
  String name = 'Guest';
  String email = '-';

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<
    void
  >
  loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    setState(
      () {
        bool isLogin =
            prefs.getBool(
              'isLoggedIn',
            ) ??
            false;

        if (isLogin) {
          name =
              prefs.getString(
                'userName',
              ) ??
              'User';
          email =
              prefs.getString(
                'userEmail',
              ) ??
              '-';
        } else {
          name = 'Belum Login';
          email = 'Silakan login terlebih dahulu';
        }
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final top = Column(
      children: [
        if (widget.embedded)
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                8,
                8,
                8,
                12,
              ),
              child: Row(
                children: [
                  const Spacer(),
                  Text(
                    'Profil Saya',
                    style: AppTextStyles.screenTitleWhite,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/settings',
                    ),
                    icon: const Icon(
                      Icons.settings_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          Container(
            color: AppColors.profileNavy,
            padding: EdgeInsets.only(
              top:
                  MediaQuery.paddingOf(
                    context,
                  ).top +
                  8,
              left: 16,
              right: 8,
              bottom: 16,
            ),
            child: Row(
              children: [
                const Spacer(),
                Text(
                  'Profil Saya',
                  style: AppTextStyles.screenTitleWhite,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    '/settings',
                  ),
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 36,
                backgroundColor: AppColors.iconCircle,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // ✅ NAME (WHITE)
                        Text(
                          name,
                          style: AppTextStyles.sectionTitle.copyWith(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Icon(
                          Icons.edit_outlined,
                          size: 18,
                          color: Colors.white70,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),

                    // ✅ EMAIL (WHITE MUTED)
                    Text(
                      email,
                      style: AppTextStyles.bodyMuted.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );

    final sheet = RoundedWhitePanel(
      topRadius: 28,
      padding: const EdgeInsets.all(
        AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Alamat Pengantaran',
                style: AppTextStyles.sectionTitle.copyWith(
                  fontSize: 15,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                  color: AppColors.primaryNavy,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          _addressCard(
            title: 'Rumah',
            address: 'Jl. Melati No. 12, Jakarta Selatan',
          ),
          const SizedBox(
            height: 10,
          ),
          _addressCard(
            title: 'Kantor',
            address: 'Gedung Aurora Lt. 5, Jl. Sudirman',
          ),
          const Spacer(),
          PrimaryButton(
            label: 'Ganti Password',
            onPressed: () {},
          ),
        ],
      ),
    );

    if (widget.embedded) {
      return ColoredBox(
        color: AppColors.profileNavy,
        child: Column(
          children: [
            top,
            Expanded(
              child: sheet,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.profileNavy,
      body: Column(
        children: [
          top,
          Expanded(
            child: sheet,
          ),
        ],
      ),
    );
  }

  Widget _addressCard({
    required String title,
    required String address,
  }) {
    return Container(
      padding: const EdgeInsets.all(
        12,
      ),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(
          14,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: AppColors.actionBlue,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.sectionTitle.copyWith(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  address,
                  style: AppTextStyles.bodyMuted,
                ),
              ],
            ),
          ),
          const Icon(
            Icons.edit_outlined,
            size: 18,
            color: AppColors.textSecondary,
          ),
          const SizedBox(
            width: 8,
          ),
          Icon(
            Icons.delete_outline,
            size: 18,
            color: AppColors.danger.withValues(
              alpha: 0.7,
            ),
          ),
        ],
      ),
    );
  }
}
