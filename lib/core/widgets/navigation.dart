import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../widgets/buttons.dart';

/// =======================================================
/// BOTTOM NAV BAR
/// =======================================================
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.variant = BottomNavVariant.white,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final BottomNavVariant variant;

  @override
  Widget build(BuildContext context) {
    final bg = variant == BottomNavVariant.navy
        ? AppColors.headerNavyAlt
        : AppColors.white;
    final active = variant == BottomNavVariant.navy
        ? AppColors.skyTab
        : AppColors.actionBlue;
    final inactive = variant == BottomNavVariant.navy
        ? Colors.white54
        : AppColors.textMuted;

    return Container(
      decoration: BoxDecoration(
        color: bg,
        boxShadow: [
          if (variant == BottomNavVariant.white)
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavItem(
                    icon: Icons.home_rounded,
                    label: 'Home',
                    selected: currentIndex == 0,
                    activeColor: active,
                    inactiveColor: inactive,
                    onTap: () => onTap(0),
                  ),
                  _NavItem(
                    icon: Icons.receipt_long_outlined,
                    label: 'Order',
                    selected: currentIndex == 1,
                    activeColor: active,
                    inactiveColor: inactive,
                    onTap: () => onTap(1),
                  ),
                  const SizedBox(width: 48),
                  _NavItem(
                    icon: Icons.percent_rounded,
                    label: 'Diskon',
                    selected: currentIndex == 3,
                    activeColor: active,
                    inactiveColor: inactive,
                    onTap: () => onTap(3),
                  ),
                  _NavItem(
                    icon: Icons.person_outline_rounded,
                    label: 'Profile',
                    selected: currentIndex == 4,
                    activeColor: active,
                    inactiveColor: inactive,
                    onTap: () => onTap(4),
                  ),
                ],
              ),

              /// CENTER ACTION
              Positioned(
                top: -10,
                child: GestureDetector(
                  onTap: () => onTap(2),
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.headerNavy,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo_white.png',
                        width: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum BottomNavVariant { white, navy }

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? activeColor : inactiveColor;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 2),
            Text(
              label,
              style: textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight:
                    selected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =======================================================
/// NAVY APP BARS
/// =======================================================
class NavyCenterTitleAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const NavyCenterTitleAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
  });

  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: AppColors.headerNavy,
      child: SizedBox(
        height: 56 + top,
        child: Padding(
          padding: EdgeInsets.only(top: top),
          child: Row(
            children: [
              leading ?? const SizedBox(width: 48),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge
                      ?.copyWith(color: AppColors.white),
                ),
              ),
              SizedBox(width: 48, child: Row(children: actions ?? [])),
            ],
          ),
        ),
      ),
    );
  }
}

class NavyBackAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const NavyBackAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.actions,
  });

  final String title;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: AppColors.headerNavy,
      child: SizedBox(
        height: 56 + top,
        child: Padding(
          padding: EdgeInsets.only(top: top),
          child: Row(
            children: [
              IconButton(
                onPressed:
                    onBack ?? () => Navigator.maybePop(context),
                icon: const Icon(Icons.chevron_left,
                    color: AppColors.white),
              ),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge
                      ?.copyWith(color: AppColors.white),
                ),
              ),
              if (actions != null)
                Row(children: actions!)
              else
                const SizedBox(width: 48),
            ],
          ),
        ),
      ),
    );
  }
}

/// =======================================================
/// CURVED NAVY HEADER
/// =======================================================
class CurvedNavyHeader extends StatelessWidget {
  const CurvedNavyHeader({
    super.key,
    required this.subtitle,
    this.heightFraction = 0.35,
  });

  final String subtitle;
  final double heightFraction;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * heightFraction;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Container(color: AppColors.headerNavy),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 75,
              decoration: BoxDecoration(
                color: AppColors.pageBg,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppDimens.radiusXl),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/logo_white.png',
                  height: 100,
                ),
                const SizedBox(height: AppDimens.md),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// =======================================================
/// LOGIN MODAL
/// =======================================================
void showLoginModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const _LoginModalCard(),
  );
}

class _LoginModalCard extends StatelessWidget {
  const _LoginModalCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(
        left: AppDimens.xl,
        right: AppDimens.xl,
        bottom: MediaQuery.paddingOf(context).bottom +
            AppDimens.xl,
      ),
      child: Material(
        color: AppColors.white,
        borderRadius:
            BorderRadius.circular(AppDimens.radiusLg),
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.xxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Masuk ke Akun Anda',
                style:
                    textTheme.titleMedium?.copyWith(fontSize: 18),
              ),
              const SizedBox(height: AppDimens.md),
              Text(
                'Anda harus masuk untuk melanjutkan.',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: AppDimens.lg),
              PrimaryButton(
                label: 'Masuk dengan Email',
                onPressed: () =>
                    Navigator.pushNamed(context, '/login'),
              ),
              const SizedBox(height: AppDimens.sm),
              OutlineNavyButton(
                label: 'Masuk dengan Google',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}