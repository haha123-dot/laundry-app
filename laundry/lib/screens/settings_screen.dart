import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import '../widgets/navy_app_bar.dart';
import '../widgets/rounded_white_panel.dart';

class SettingsScreen
    extends
        StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: AppColors.profileNavy,
      appBar: NavyBackAppBar(
        title: 'Pengaturan',
        onBack: () => Navigator.pop(
          context,
        ),
      ),
      body: RoundedWhitePanel(
        topRadius: 28,
        child: ListView(
          padding: const EdgeInsets.all(
            AppSpacing.xl,
          ),
          children: [
            Text(
              'Umum',
              style: AppTextStyles.caption.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 8,
            ),

            _tile(
              Icons.language,
              'Bahasa',
              trailing: 'Indonesia',
              onTap: () => _languageSheet(
                context,
              ),
            ),

            const SizedBox(
              height: AppSpacing.xl,
            ),

            Text(
              'Lainnya',
              style: AppTextStyles.caption.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 8,
            ),

            _tile(
              Icons.privacy_tip_outlined,
              'Kebijakan Privasi',
              onTap: () => Navigator.pushNamed(
                context,
                '/privacy',
              ),
            ),
            _tile(
              Icons.help_outline,
              'Bantuan',
              onTap: () => Navigator.pushNamed(
                context,
                '/help',
              ),
            ),
            _tile(
              Icons.article_outlined,
              'Syarat dan Ketentuan',
              onTap: () => Navigator.pushNamed(
                context,
                '/terms',
              ),
            ),
            _tile(
              Icons.info_outline,
              'Tentang',
              onTap: () => Navigator.pushNamed(
                context,
                '/about',
              ),
            ),

            const SizedBox(
              height: AppSpacing.xl,
            ),

            Text(
              'Tindakan Berbahaya',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.danger,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 8,
            ),

            _tile(
              Icons.person_off_outlined,
              'Hapus Akun',
              danger: true,
              onTap: () => _confirmDelete(
                context,
              ),
            ),
            _tile(
              Icons.logout,
              'Keluar',
              danger: true,
              onTap: () => _confirmLogout(
                context,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile(
    IconData icon,
    String title, {
    String? trailing,
    bool danger = false,
    VoidCallback? onTap,
  }) {
    final c = danger
        ? AppColors.danger
        : AppColors.headerNavy;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: c,
      ),
      title: Text(
        title,
        style: AppTextStyles.body.copyWith(
          color: c,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing !=
              null)
            Text(
              trailing,
              style: AppTextStyles.bodyMuted,
            ),
          Icon(
            Icons.chevron_right,
            color: AppColors.textMuted,
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  Future<
    void
  >
  _languageSheet(
    BuildContext context,
  ) {
    return showModalBottomSheet<
      void
    >(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (
            ctx,
          ) => const _LanguageSheetBody(),
    );
  }

  // ✅ FIX: reset login state
  Future<
    void
  >
  _logoutAndGoHome(
    BuildContext context,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(
      'isLoggedIn',
      false,
    );

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/main',
      (
        route,
      ) => false,
    );
  }

  void _confirmDelete(
    BuildContext context,
  ) {
    showDialog<
      void
    >(
      context: context,
      builder:
          (
            ctx,
          ) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                16,
              ),
            ),
            title: Text(
              'Hapus Akun',
              style: AppTextStyles.sectionTitle,
            ),
            content: Text(
              'Akun akan keluar dari sistem (simulasi).',
              style: AppTextStyles.bodyMuted,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(
                  ctx,
                ),
                child: Text(
                  'Batal',
                  style: AppTextStyles.bodyMuted,
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(
                    ctx,
                  );
                  await _logoutAndGoHome(
                    context,
                  );
                },
                child: Text(
                  'Hapus Akun',
                  style: AppTextStyles.link.copyWith(
                    color: AppColors.primaryNavy,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  void _confirmLogout(
    BuildContext context,
  ) {
    showDialog<
      void
    >(
      context: context,
      builder:
          (
            ctx,
          ) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                16,
              ),
            ),
            title: Text(
              'Keluar',
              style: AppTextStyles.sectionTitle,
            ),
            content: Text(
              'Apakah kamu yakin ingin keluar?',
              style: AppTextStyles.bodyMuted,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(
                  ctx,
                ),
                child: Text(
                  'Batal',
                  style: AppTextStyles.bodyMuted,
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(
                    ctx,
                  );
                  await _logoutAndGoHome(
                    context,
                  );
                },
                child: Text(
                  'Keluar',
                  style: AppTextStyles.link.copyWith(
                    color: AppColors.primaryNavy,
                  ),
                ),
              ),
            ],
          ),
    );
  }
}

// ================= LANGUAGE SHEET =================

class _LanguageSheetBody
    extends
        StatefulWidget {
  const _LanguageSheetBody();

  @override
  State<
    _LanguageSheetBody
  >
  createState() => _LanguageSheetBodyState();
}

class _LanguageSheetBodyState
    extends
        State<
          _LanguageSheetBody
        > {
  int _selected = 0;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.all(
        AppSpacing.xl,
      ),
      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text(
              'Indonesia',
            ),
            trailing:
                _selected ==
                    0
                ? const Icon(
                    Icons.check_circle,
                    color: AppColors.primaryNavy,
                  )
                : null,
            onTap: () => setState(
              () => _selected = 0,
            ),
          ),
          ListTile(
            title: Text(
              'English',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textMuted,
              ),
            ),
            subtitle: Text(
              'Segera hadir',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.danger,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
