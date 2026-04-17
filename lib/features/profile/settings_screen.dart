import 'package:flutter/material.dart';

// ================= CONSTANTS =================
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';

// ================= WIDGETS =================
import '../../core/widgets/navigation.dart';
import '../../core/widgets/rounded_white_panel.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.profileNavy,

      // ================= APP BAR =================
      appBar: NavyBackAppBar(
        title: 'Pengaturan',
        onBack: () => Navigator.pop(context),
      ),

      // ================= BODY =================
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return RoundedWhitePanel(
                  topRadius: AppDimens.radiusXl,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: ListView(
                      padding: const EdgeInsets.all(AppDimens.xl),
                      children: [
                        Text(
                          'Umum',
                          style: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),

                        _tile(
                          context,
                          Icons.language,
                          'Bahasa',
                          trailing: 'Indonesia',
                          onTap: () => _languageSheet(context),
                        ),

                        const SizedBox(height: AppDimens.xl),

                        Text(
                          'Lainnya',
                          style: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),

                        _tile(
                          context,
                          Icons.privacy_tip_outlined,
                          'Kebijakan Privasi',
                          onTap: () => Navigator.pushNamed(context, '/privacy'),
                        ),
                        _tile(
                          context,
                          Icons.help_outline,
                          'Bantuan',
                          onTap: () => Navigator.pushNamed(context, '/help'),
                        ),
                        _tile(
                          context,
                          Icons.article_outlined,
                          'Syarat dan Ketentuan',
                          onTap: () => Navigator.pushNamed(context, '/terms'),
                        ),
                        _tile(
                          context,
                          Icons.info_outline,
                          'Tentang',
                          onTap: () => Navigator.pushNamed(context, '/about'),
                        ),

                        const SizedBox(height: AppDimens.xl),

                        Text(
                          'Tindakan Berbahaya',
                          style: textTheme.bodySmall?.copyWith(
                            color: AppColors.danger,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),

                        _tile(
                          context,
                          Icons.person_off_outlined,
                          'Hapus Akun',
                          danger: true,
                          onTap: () => _confirmDelete(context),
                        ),
                        _tile(
                          context,
                          Icons.logout,
                          'Keluar',
                          danger: true,
                          onTap: () => _confirmLogout(context),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ================= LIST TILE =================
  Widget _tile(
    BuildContext context,
    IconData icon,
    String title, {
    String? trailing,
    bool danger = false,
    VoidCallback? onTap,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final color = danger ? AppColors.danger : AppColors.headerNavy;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: textTheme.bodyLarge?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null) Text(trailing, style: textTheme.bodyMedium),
          const Icon(Icons.chevron_right, color: AppColors.textMuted),
        ],
      ),
      onTap: onTap,
    );
  }

  // ================= LANGUAGE BOTTOM SHEET =================
  Future<void> _languageSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const _LanguageSheetBody(),
    );
  }

  // ================= CONFIRM DELETE =================
  void _confirmDelete(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Hapus Akun', style: textTheme.titleMedium),
        content: Text(
          'Apakah kamu yakin ingin menghapus akun ini?\n'
          'Semua data akan hilang dan tidak bisa dikembalikan.',
          style: textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Batal', style: textTheme.bodyMedium),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Hapus Akun',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.primaryNavy,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= CONFIRM LOGOUT =================
  void _confirmLogout(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Keluar', style: textTheme.titleMedium),
        content: Text(
          'Apakah kamu yakin ingin keluar dari akun?',
          style: textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Batal', style: textTheme.bodyMedium),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Keluar',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.primaryNavy,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= LANGUAGE SHEET =================
class _LanguageSheetBody extends StatefulWidget {
  const _LanguageSheetBody();

  @override
  State<_LanguageSheetBody> createState() => _LanguageSheetBodyState();
}

class _LanguageSheetBodyState extends State<_LanguageSheetBody> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.all(AppDimens.xl),
      padding: const EdgeInsets.all(AppDimens.lg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Batal',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.linkBlue,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Simpan',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.linkBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            title: const Text('Indonesia'),
            trailing: _selected == 0
                ? const Icon(Icons.check_circle, color: AppColors.primaryNavy)
                : null,
            onTap: () => setState(() => _selected = 0),
          ),
          ListTile(
            title: const Text('English'),
            trailing: _selected == 1
                ? const Icon(Icons.check_circle, color: AppColors.primaryNavy)
                : null,
            onTap: () => setState(() => _selected = 1),
          ),
        ],
      ),
    );
  }
}
