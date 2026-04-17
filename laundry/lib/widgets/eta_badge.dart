import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Jenis ETA untuk menentukan warna badge
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _resolveColor(EtaType type) {
    switch (type) {
      case EtaType.fast:
        return AppColors.actionBlue; // 🔵
      case EtaType.long:
        return Colors.purple; // 🟣
      case EtaType.express:
        return Colors.redAccent; // 🔴
      case EtaType.normal:
        return AppColors.success; // 🟢
    }
  }
}