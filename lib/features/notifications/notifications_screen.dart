import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';

import '../../core/widgets/indicators.dart';
import '../../core/widgets/notification_list_tile.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _filter = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.pageBgCool,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: AppColors.pageBgCool,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left,
            color: AppColors.primaryNavy,
            size: 28,
          ),
        ),
        title: Text(
          'Notifikasi',
          style: textTheme.titleLarge?.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),

      // ================= BODY =================
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.xl,
              vertical: AppDimens.sm,
            ),
            child: Row(
              children: [
                NotificationFilterTab(
                  icon: Icons.list_alt_rounded,
                  label: 'Semua',
                  selected: _filter == 0,
                  activeColor: AppColors.accentBlue,
                  onTap: () => setState(() => _filter = 0),
                ),
                NotificationFilterTab(
                  icon: Icons.assignment_outlined,
                  label: 'Pesanan',
                  selected: _filter == 1,
                  activeColor: AppColors.skyTab,
                  onTap: () => setState(() => _filter = 1),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.xl,
              ),
              children:
                  _filter == 0 ? _buildAll(textTheme) : _buildOrdersOnly(textTheme),
            ),
          ),
        ],
      ),
    );
  }

  // ================= ALL NOTIFICATIONS =================
  List<Widget> _buildAll(TextTheme textTheme) {
    return [
      _dateHeader('Hari Ini', textTheme),
      const NotificationListTile(
        leading: NotificationIconBubble(
          icon: Icons.chat_bubble_outline,
          color: AppColors.actionBlue,
          badge: true,
        ),
        title: 'Konfirmasi Order',
        subtitle: 'Pesanan #001156 sudah diproses',
        dateLabel: '18 Juli 2025',
      ),
      const NotificationListTile(
        leading: NotificationIconBubble(
          icon: Icons.chat_bubble_outline,
          color: AppColors.actionBlue,
          badge: true,
        ),
        title: 'Konfirmasi Order',
        subtitle: 'Pesanan #001156 telah dikonfirmasi',
        dateLabel: '18 Juli 2025',
      ),
      const NotificationListTile(
        leading: NotificationIconBubble(
          icon: Icons.settings_outlined,
          color: AppColors.skyTab,
        ),
        title: 'Sistem',
        subtitle: 'Laundry sudah buka! Kami siap melayani anda!',
        dateLabel: '18 Juli 2025',
      ),
      _dateHeader('Kemarin', textTheme),
      const NotificationListTile(
        leading: NotificationIconBubble(
          icon: Icons.settings_outlined,
          color: AppColors.skyTab,
        ),
        title: 'Sistem',
        subtitle:
            'Laundry sudah tutup! Kami beroperasi kembali besok.',
        dateLabel: '17 Juli 2025',
      ),
      const NotificationListTile(
        leading: NotificationIconBubble(
          icon: Icons.chat_bubble_outline,
          color: AppColors.actionBlue,
        ),
        title: 'Konfirmasi Order',
        subtitle: 'Pesanan #001188 sudah selesai',
        dateLabel: '17 Juli 2025',
      ),
      const NotificationListTile(
        leading: NotificationIconBubble(
          icon: Icons.campaign_outlined,
          color: AppColors.textDark,
        ),
        title: 'Reminder',
        subtitle: 'Jangan lupa pilih pewangi favorit anda!',
        dateLabel: '17 Juli 2025',
      ),
    ];
  }

  // ================= ORDERS ONLY =================
  List<Widget> _buildOrdersOnly(TextTheme textTheme) {
    return [
      _dateHeader('Hari Ini', textTheme),
      const NotificationListTile(
        leading: NotificationIconBubble(
          icon: Icons.chat_bubble_outline,
          color: AppColors.actionBlue,
          badge: true,
        ),
        title: 'Konfirmasi Order',
        subtitle: 'Pesanan #001156 sudah diproses',
        dateLabel: '18 Juli 2025',
      ),
      const NotificationListTile(
        leading: NotificationIconBubble(
          icon: Icons.chat_bubble_outline,
          color: AppColors.actionBlue,
          badge: true,
        ),
        title: 'Konfirmasi Order',
        subtitle: 'Pesanan #001156 telah dikonfirmasi',
        dateLabel: '18 Juli 2025',
      ),
      _dateHeader('Kemarin', textTheme),
      const NotificationListTile(
        leading: NotificationIconBubble(
          icon: Icons.chat_bubble_outline,
          color: AppColors.actionBlue,
        ),
        title: 'Konfirmasi Order',
        subtitle: 'Pesanan #001188 sudah selesai',
        dateLabel: '17 Juli 2025',
      ),
      const NotificationListTile(
        leading: NotificationIconBubble(
          icon: Icons.chat_bubble_outline,
          color: AppColors.actionBlue,
        ),
        title: 'Konfirmasi Order',
        subtitle: 'Pesanan #001188 sedang diproses',
        dateLabel: '16 Juli 2025',
      ),
    ];
  }

  // ================= DATE HEADER =================
  Widget _dateHeader(String text, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Text(
        text,
        style: textTheme.titleMedium?.copyWith(fontSize: 15),
      ),
    );
  }
}
