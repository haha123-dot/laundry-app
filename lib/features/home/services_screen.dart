import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';

import '../../core/widgets/navigation.dart';
import '../../core/widgets/forms.dart';
import '../../core/widgets/indicators.dart';
import '../../core/widgets/rounded_white_panel.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.headerNavy,

      // ================= APP BAR =================
      appBar: NavyCenterTitleAppBar(
        title: 'Layanan',
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.white,
              size: 26,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),

      // ================= BODY =================
      body: Column(
        children: [
          Expanded(
            child: RoundedWhitePanel(
              topRadius: AppDimens.radiusXl,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppDimens.xl,
                  AppDimens.xl,
                  AppDimens.xl,
                  AppDimens.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SearchFieldRounded(),

                    const SizedBox(height: AppDimens.lg),
                    Text(
                      'Layanan Lainnya',
                      style: textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppDimens.md),

                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: AppDimens.md,
                      crossAxisSpacing: AppDimens.md,
                      childAspectRatio: 0.82,
                      children: [
                        _gridCard(
                          context,
                          title: 'Cuci Regular',
                          price: 'Rp 20.000 / Plastik',
                          eta: 'ETA 10 jam',
                          etaType: EtaType.normal,
                        ),
                        _gridCard(
                          context,
                          title: 'Cuci Setrika',
                          price: 'Rp 28.000 / Plastik',
                          eta: 'ETA 11 jam',
                          etaType: EtaType.fast,
                        ),
                        _gridCard(
                          context,
                          title: 'Cuci Kering',
                          price: 'Rp 23.000 / Plastik',
                          eta: 'ETA 12 jam',
                          etaType: EtaType.long,
                        ),
                        _gridCard(
                          context,
                          title: 'Paket Layanan',
                          price: 'Rp 48.000 / Plastik',
                          eta: 'Express',
                          etaType: EtaType.express,
                        ),
                      ],
                    ),

                    const SizedBox(height: AppDimens.xl),
                    _bedcoverCard(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= GRID CARD =================
  Widget _gridCard(
    BuildContext context, {
    required String title,
    required String price,
    required String eta,
    required EtaType etaType,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppDimens.cardRadius),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/service-detail'),
        borderRadius: BorderRadius.circular(AppDimens.cardRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.serviceCardTint,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(AppDimens.radiusLg),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.local_laundry_service,
                        size: 42,
                        color: AppColors.actionBlue,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: EtaBadge(label: eta, type: etaType),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          textTheme.titleMedium?.copyWith(fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      price,
                      style:
                          textTheme.bodySmall?.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bedcoverCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppDimens.cardRadius),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/service-detail'),
        borderRadius: BorderRadius.circular(AppDimens.cardRadius),
        child: Container(
          padding: const EdgeInsets.all(AppDimens.md),
          child: Row(
            children: [
              Container(
                width: 76,
                height: 68,
                decoration: BoxDecoration(
                  color: AppColors.serviceCardTint,
                  borderRadius:
                      BorderRadius.circular(AppDimens.radiusMd),
                ),
                child: const Icon(
                  Icons.local_laundry_service,
                  size: 34,
                  color: AppColors.actionBlue,
                ),
              ),
              const SizedBox(width: AppDimens.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cuci Bedcover / Selimut / Sprei',
                      style:
                          textTheme.titleMedium?.copyWith(fontSize: 13),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Mulai Rp45.000',
                      style:
                          textTheme.bodyMedium?.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              const EtaBadge(
                label: 'ETA 24 jam',
                type: EtaType.long,
              ),
            ],
          ),
        ),
      ),
    );
  }
}