import 'dart:async';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';

/// =======================================================
/// ETA BADGE
/// =======================================================

enum EtaType {
  normal,   // hijau
  fast,     // biru
  long,     // ungu
  express,  // merah
}

class EtaBadge extends StatelessWidget {
  const EtaBadge({
    super.key,
    required this.label,
    this.type = EtaType.normal,
  });

  final String label;
  final EtaType type;

  @override
  Widget build(BuildContext context) {
    final color = _resolveColor(type);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label,
        style: textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Color _resolveColor(EtaType type) {
    switch (type) {
      case EtaType.fast:
        return AppColors.actionBlue;
      case EtaType.long:
        return Colors.purple;
      case EtaType.express:
        return Colors.redAccent;
      case EtaType.normal:
        return AppColors.success;
    }
  }
}

/// =======================================================
/// ORDER STEP PROGRESS
/// =======================================================
class OrderStepProgressBar extends StatelessWidget {
  const OrderStepProgressBar({super.key, this.activeIndex = 1});

  /// 0..3 — index step aktif
  final int activeIndex;

  static const _labels = ['Diambil', 'Dicuci', 'Diantar', 'Sampai'];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(
          children: [
            for (var s = 0; s < _labels.length; s++) ...[
              _StepDot(active: s == activeIndex, done: s < activeIndex),
              if (s < _labels.length - 1)
                Expanded(
                  child: Container(
                    height: 3,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: s < activeIndex
                          ? AppColors.actionBlue
                          : AppColors.borderLight,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
            ],
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_labels.length, (s) {
            final active = s == activeIndex;
            return Expanded(
              child: Text(
                _labels[s],
                textAlign: TextAlign.center,
                style: textTheme.bodySmall?.copyWith(
                  fontSize: 10,
                  fontWeight: active
                      ? FontWeight.w700
                      : FontWeight.w500,
                  color: active
                      ? AppColors.actionBlue
                      : AppColors.textMuted,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _StepDot extends StatelessWidget {
  const _StepDot({required this.active, required this.done});

  final bool active;
  final bool done;

  @override
  Widget build(BuildContext context) {
    final on = active || done;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: on ? AppColors.actionBlue : AppColors.borderLight,
          border: Border.all(color: AppColors.white, width: 2),
          boxShadow: active
              ? [
                  BoxShadow(
                    color:
                        AppColors.actionBlue.withOpacity(0.45),
                    blurRadius: 6,
                  ),
                ]
              : null,
        ),
      ),
    );
  }
}

/// =======================================================
/// ORDER STATUS SEGMENTED BAR
/// =======================================================
class OrderStatusSegmentedBar extends StatelessWidget {
  const OrderStatusSegmentedBar({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  static const labels = ['Pesan', 'Proses', 'Selesai'];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.ordersNavy,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: List.generate(labels.length, (i) {
          final selected = i == selectedIndex;
          return Expanded(
            child: InkWell(
              onTap: () => onChanged(i),
              borderRadius: BorderRadius.circular(12),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding:
                    const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.white
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  labels[i],
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: selected
                        ? AppColors.ordersNavy
                        : AppColors.white,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// =======================================================
/// NOTIFICATION FILTER TAB
/// =======================================================
class NotificationFilterTab extends StatelessWidget {
  const NotificationFilterTab({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.activeColor,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    final c = selected
        ? (activeColor ?? AppColors.skyTab)
        : AppColors.textMuted;
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: c),
              const SizedBox(width: 8),
              Text(
                label,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: selected
                      ? FontWeight.w700
                      : FontWeight.w500,
                  color: c,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// =======================================================
/// ONBOARDING PAGE CONTENT
/// =======================================================
class OnboardingPageContent extends StatelessWidget {
  const OnboardingPageContent({
    super.key,
    required this.illustration,
    required this.title,
    required this.description,
  });

  final Widget illustration;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Expanded(
          flex: 11,
          child: Padding(
            padding:
                const EdgeInsets.fromLTRB(20, 4, 20, 0),
            child: Center(child: illustration),
          ),
        ),
        Expanded(
          flex: 9,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: textTheme.displayLarge,
                ),
                const SizedBox(height: AppDimens.lg),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// =======================================================
/// OFFER IMAGE AUTO SLIDER
/// =======================================================
class OfferImageAutoSlider extends StatefulWidget {
  const OfferImageAutoSlider({
    super.key,
    required this.onTap,
  });

  final ValueChanged<int> onTap;

  @override
  State<OfferImageAutoSlider> createState() =>
      _OfferImageAutoSliderState();
}

class _OfferImageAutoSliderState
    extends State<OfferImageAutoSlider> {
  final PageController _controller = PageController();
  Timer? _timer;
  int _index = 0;

  final List<String> _images = const [
    'assets/images/pro.png',
    'assets/images/diskon.png',
    'assets/images/diskn bed.png',
    'assets/images/payday.png',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 4),
      (_) {
        _index = (_index + 1) % _images.length;
        _controller.animateToPage(
          _index,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: PageView.builder(
        controller: _controller,
        itemCount: _images.length,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () => widget.onTap(i),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppDimens.cardRadius),
                child: Image.asset(
                  _images[i],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
