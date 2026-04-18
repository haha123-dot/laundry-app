import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wushlaundry/widgets/active_order_card.dart';
import 'package:wushlaundry/widgets/eta_badge.dart';
import 'package:wushlaundry/widgets/login_modal_sheet.dart';
import 'package:wushlaundry/widgets/offer_image_slider.dart';
import 'package:wushlaundry/widgets/rounded_white_panel.dart';
import 'package:wushlaundry/widgets/section_header_row.dart';
import 'package:wushlaundry/widgets/service_card_compact.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';

class HomeScreen
    extends
        StatefulWidget {
  const HomeScreen({
    super.key,
    this.loggedIn = false,
    this.userFirstName,
    this.onOpenNotifications,
    this.onOpenServices,
    this.onOpenServiceDetail,
    this.onOpenPro,
  });

  final bool loggedIn;
  final String? userFirstName;
  final VoidCallback? onOpenNotifications;
  final VoidCallback? onOpenServices;
  final VoidCallback? onOpenServiceDetail;
  final VoidCallback? onOpenPro;

  @override
  State<
    HomeScreen
  >
  createState() => _HomeScreenState();
}

class _HomeScreenState
    extends
        State<
          HomeScreen
        > {
  final PageController _controller = PageController(
    viewportFraction: 0.45,
  );

  int _currentIndex = 0;
  Timer? _timer;

  // 🔥 ACTIVE ORDER STATE
  bool hasOrder = false;
  String orderTitle = '';
  String orderSubtitle = '';

  final List<
    Map<
      String,
      dynamic
    >
  >
  items = [
    {
      'title': 'Cuci Regular',
      'price': 'Rp 20.000/plastik',
      'eta': 'ETA 10 jam',
      'type': EtaType.normal,
    },
    {
      'title': 'Cuci Setrika',
      'price': 'Rp 25.000/plastik',
      'eta': 'ETA 11 jam',
      'type': EtaType.fast,
    },
    {
      'title': 'Cuci Kering',
      'price': 'Rp 23.000/plastik',
      'eta': 'ETA 12 jam',
      'type': EtaType.long,
    },
    {
      'title': 'Paket Layanan',
      'price': 'Rp 48.000/plastik',
      'eta': 'Express',
      'type': EtaType.fast,
    },
  ];

  @override
  void initState() {
    super.initState();

    loadActiveOrder();

    _timer = Timer.periodic(
      const Duration(
        seconds: 3,
      ),
      (
        _,
      ) {
        if (!_controller.hasClients) return;

        final next =
            (_currentIndex +
                1) %
            items.length;

        _controller.animateToPage(
          next,
          duration: const Duration(
            milliseconds: 400,
          ),
          curve: Curves.easeInOut,
        );

        setState(
          () {
            _currentIndex = next;
          },
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadActiveOrder(); // refresh saat balik ke home
  }

  // 🔥 LOAD ORDER + VALIDASI
  Future<
    void
  >
  loadActiveOrder() async {
    final prefs = await SharedPreferences.getInstance();

    final isLogin =
        prefs.getBool(
          'isLoggedIn',
        ) ??
        false;

    // ❌ belum login → kosong
    if (!isLogin) {
      setState(
        () => hasOrder = false,
      );
      return;
    }

    final service = prefs.getString(
      'active_order_service',
    );
    final qty = prefs.getInt(
      'active_order_qty',
    );
    final pickup = prefs.getString(
      'active_order_pickup',
    );
    final delivery = prefs.getString(
      'active_order_delivery',
    );

    // ❌ belum order / data ga lengkap
    if (service ==
            null ||
        service.isEmpty ||
        qty ==
            null ||
        pickup ==
            null ||
        delivery ==
            null) {
      setState(
        () => hasOrder = false,
      );
      return;
    }

    // ✅ tampilkan
    setState(
      () {
        hasOrder = true;
        orderTitle = 'Pesanan kamu sedang diproses';
        orderSubtitle = '$service • $qty plastik\nPickup: $pickup\nDelivery: $delivery';
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _handleServiceTap(
    BuildContext context,
  ) {
    if (!widget.loggedIn) {
      showLoginModal(
        context,
      );
      return;
    }
    widget.onOpenServiceDetail?.call();
  }

  void _handleNotificationTap(
    BuildContext context,
  ) {
    if (!widget.loggedIn) {
      showLoginModal(
        context,
      );
      return;
    }
    widget.onOpenNotifications?.call();
  }

  void _handleOfferTap(
    BuildContext context,
    int index,
  ) {
    if (!widget.loggedIn) {
      showLoginModal(
        context,
      );
      return;
    }
    if (index ==
        0) {
      widget.onOpenPro?.call();
    } else {
      Navigator.pushNamed(
        context,
        '/offers-full',
      );
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return ColoredBox(
      color: AppColors.headerNavy,
      child: Column(
        children: [
          HomeNavyHeaderBlock(
            onNotification: () => _handleNotificationTap(
              context,
            ),
          ),

          Expanded(
            child: RoundedWhitePanel(
              topRadius: 40,
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.xl,
                AppSpacing.xl,
                8,
              ),
              child: ScrollConfiguration(
                behavior: const _NoOverscrollBehavior(),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.loggedIn &&
                          widget.userFirstName !=
                              null) ...[
                        Text(
                          'Hi ${widget.userFirstName} 👋',
                          style: AppTextStyles.screenTitleNavy.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                      ],

                      const SectionHeaderRow(
                        title: 'Layanan Laundry Kami',
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      SizedBox(
                        height: 140,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: items.length,
                          itemBuilder:
                              (
                                context,
                                index,
                              ) {
                                final item = items[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    right: 12,
                                  ),
                                  child: ServiceCardCompact(
                                    title: item['title'],
                                    priceLabel: item['price'],
                                    etaLabel: item['eta'],
                                    etaType: item['type'],
                                    selected:
                                        _currentIndex ==
                                        index,
                                    onTap: () => _handleServiceTap(
                                      context,
                                    ),
                                  ),
                                );
                              },
                        ),
                      ),

                      const SizedBox(
                        height: AppSpacing.xl,
                      ),

                      const SectionHeaderRow(
                        title: 'Pesanan Aktif',
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      // 🔥 AUTO EMPTY / ADA
                      ActiveOrderCard(
                        empty: !hasOrder,
                        statusTitle: orderTitle,
                        subtitle: orderSubtitle,
                        currentStep: 1,
                        onTap: hasOrder
                            ? () {
                                Navigator.pushNamed(
                                  context,
                                  '/order-detail',
                                );
                              }
                            : null,
                      ),

                      const SizedBox(
                        height: AppSpacing.xl,
                      ),

                      SectionHeaderRow(
                        title: 'Penawaran Khusus',
                        actionLabel: 'Lihat semua',
                        onAction: () => _handleOfferTap(
                          context,
                          1,
                        ),
                      ),

                      OfferImageAutoSlider(
                        onTap:
                            (
                              index,
                            ) => _handleOfferTap(
                              context,
                              index,
                            ),
                      ),

                      const SizedBox(
                        height: 24,
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
}

// ================= HEADER =================
class HomeNavyHeaderBlock
    extends
        StatelessWidget {
  const HomeNavyHeaderBlock({
    super.key,
    this.onNotification,
  });

  final VoidCallback? onNotification;

  @override
  Widget build(
    BuildContext context,
  ) {
    final top = MediaQuery.of(
      context,
    ).padding.top;

    return Container(
      color: AppColors.headerNavy,
      padding: EdgeInsets.fromLTRB(
        20,
        top +
            15,
        20,
        20,
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/logo_white.png',
            height: 100,
          ),
          const Spacer(),
          IconButton(
            onPressed: onNotification,
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ================= NO OVERSCROLL =================
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
