import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/widgets/buttons.dart';
import '../../core/widgets/rounded_white_panel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    this.embedded = false,
  });

  final bool embedded;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'Guest';
  String email = '-';

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      final isLogin = prefs.getBool('isLoggedIn') ?? false;

      if (isLogin) {
        name = prefs.getString('userName') ?? 'User';
        email = prefs.getString('userEmail') ?? '-';
      } else {
        name = 'Belum Login';
        email = 'Silakan login terlebih dahulu';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // ================= HEADER =================
    final top = Column(
      children: [
        widget.embedded
            ? SafeArea(
                bottom: false,
                child: Padding(
                  padding:
                      const EdgeInsets.fromLTRB(8, 8, 8, 12),
                  child: Row(
                    children: [
                      const Spacer(),
                      Text(
                        'Profil Saya',
                        style: textTheme.titleLarge
                            ?.copyWith(color: Colors.white),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () =>
                            Navigator.pushNamed(
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
            : Container(
                color: AppColors.profileNavy,
                padding: EdgeInsets.only(
                  top: MediaQuery.paddingOf(context).top +
                      8,
                  left: AppDimens.md,
                  right: AppDimens.sm,
                  bottom: AppDimens.md,
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    Text(
                      'Profil Saya',
                      style: textTheme.titleLarge
                          ?.copyWith(color: Colors.white),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () =>
                          Navigator.pushNamed(
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
            horizontal: AppDimens.xl,
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
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: textTheme.titleMedium
                              ?.copyWith(fontSize: 17),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.edit_outlined,
                          size: 18,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );

    // ================= CONTENT =================
    final sheet = RoundedWhitePanel(
      topRadius: AppDimens.radiusXl,
      padding: const EdgeInsets.all(AppDimens.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Alamat Pengantaran',
                style: textTheme.titleMedium
                    ?.copyWith(fontSize: 15),
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
          const SizedBox(height: 8),

          _addressCard(
            context,
            title: 'Rumah',
            address:
                'Jl. Melati No. 12, Jakarta Selatan',
          ),
          const SizedBox(height: 10),
          _addressCard(
            context,
            title: 'Kantor',
            address:
                'Gedung Aurora Lt. 5, Jl. Sudirman',
          ),

          const Spacer(),

          PrimaryButton(
            label: 'Ganti Password',
            onPressed: () {},
          ),
        ],
      ),
    );

    // ================= LAYOUT =================
    if (widget.embedded) {
      return ColoredBox(
        color: AppColors.profileNavy,
        child: Column(
          children: [
            top,
            Expanded(child: sheet),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.profileNavy,
      body: Column(
        children: [
          top,
          Expanded(child: sheet),
        ],
      ),
    );
  }

  // ================= ADDRESS CARD =================
  Widget _addressCard(
    BuildContext context, {
    required String title,
    required String address,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius:
            BorderRadius.circular(AppDimens.inputRadius),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: AppColors.actionBlue,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleMedium
                      ?.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  address,
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const Icon(
            Icons.edit_outlined,
            size: 18,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.delete_outline,
            size: 18,
            color: AppColors.danger.withOpacity(0.7),
          ),
        ],
      ),
    );
  }
}