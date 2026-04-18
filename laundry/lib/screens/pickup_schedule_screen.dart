import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import '../widgets/navy_app_bar.dart';
import '../widgets/primary_button.dart';
import '../widgets/rounded_white_panel.dart';

class PickupScheduleScreen
    extends
        StatefulWidget {
  const PickupScheduleScreen({
    super.key,
  });

  @override
  State<
    PickupScheduleScreen
  >
  createState() => _PickupScheduleScreenState();
}

class _PickupScheduleScreenState
    extends
        State<
          PickupScheduleScreen
        > {
  TimeOfDay? _pickupTime;
  TimeOfDay? _deliveryTime;

  bool _showAddressOptions = false;

  final TextEditingController _customAddressController = TextEditingController();

  String _selectedAddressType = 'Rumah';

  final Map<
    String,
    String
  >
  _addresses = {
    'Rumah': 'Jl. Matahari No. 456',
    'Kantor': 'Jl. Gading No. 753',
  };

  String _formatTime(
    TimeOfDay? time,
  ) {
    if (time ==
        null)
      return 'Pilih jam';
    final h = time.hour.toString().padLeft(
      2,
      '0',
    );
    final m = time.minute.toString().padLeft(
      2,
      '0',
    );
    return '$h:$m';
  }

  Future<
    void
  >
  _pickTime({
    required bool isPickup,
  }) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked !=
        null) {
      setState(
        () {
          if (isPickup) {
            _pickupTime = picked;
          } else {
            _deliveryTime = picked;
          }
        },
      );
    }
  }

  Widget _addressOption(
    String key,
  ) {
    return ListTile(
      leading: const Icon(
        Icons.home_outlined,
      ),
      title: Text(
        key,
      ),
      subtitle: Text(
        _addresses[key]!,
      ),
      onTap: () {
        setState(
          () {
            _selectedAddressType = key;
            _showAddressOptions = false;
          },
        );
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final args =
        ModalRoute.of(
              context,
            )?.settings.arguments
            as Map? ??
        {};

    final selectedAddress =
        _selectedAddressType ==
            'Custom'
        ? _customAddressController.text
        : (_addresses[_selectedAddressType] ??
              '');

    return Scaffold(
      backgroundColor: AppColors.headerNavy,
      appBar: NavyBackAppBar(
        title: 'Pengambilan dan Pengantaran',
        onBack: () => Navigator.pop(
          context,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: RoundedWhitePanel(
              topRadius: AppSpacing.sheetTopRadius,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(
                  AppSpacing.xl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ================= PICKUP =================
                    Text(
                      'Waktu Pengambilan',
                      style: AppTextStyles.sectionTitle.copyWith(
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _pickTime(
                              isPickup: true,
                            ),
                            child: _dateField(
                              'Hari ini',
                              Icons.calendar_today_outlined,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _pickTime(
                              isPickup: true,
                            ),
                            child: _dateField(
                              _formatTime(
                                _pickupTime,
                              ),
                              Icons.access_time,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    _iconField(
                      'Dijemput',
                      Icons.person_outline,
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    // ================= DELIVERY =================
                    Text(
                      'Waktu Pengantaran',
                      style: AppTextStyles.sectionTitle.copyWith(
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: _dateField(
                            'Besok',
                            Icons.calendar_today_outlined,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _pickTime(
                              isPickup: false,
                            ),
                            child: _dateField(
                              _formatTime(
                                _deliveryTime,
                              ),
                              Icons.access_time,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    _iconField(
                      'Diantar',
                      Icons.person_outline,
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    // ================= ADDRESS =================
                    Text(
                      'Alamat Pengiriman',
                      style: AppTextStyles.sectionTitle.copyWith(
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            _showAddressOptions = !_showAddressOptions;
                          },
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.inputFill,
                          borderRadius: BorderRadius.circular(
                            14,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _selectedAddressType,
                                    style: AppTextStyles.sectionTitle.copyWith(
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    selectedAddress,
                                    style: AppTextStyles.bodyMuted,
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                            ),
                          ],
                        ),
                      ),
                    ),

                    AnimatedCrossFade(
                      duration: const Duration(
                        milliseconds: 200,
                      ),
                      crossFadeState: _showAddressOptions
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      firstChild: const SizedBox.shrink(),
                      secondChild: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          _addressOption(
                            'Rumah',
                          ),
                          _addressOption(
                            'Kantor',
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          TextField(
                            controller: _customAddressController,
                            decoration: InputDecoration(
                              hintText: 'Atau masukkan alamat lain...',
                              filled: true,
                              fillColor: AppColors.inputFill,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  14,
                                ),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged:
                                (
                                  _,
                                ) => setState(
                                  () {},
                                ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          PrimaryButton(
                            label: 'Gunakan alamat ini',
                            onPressed: () {
                              if (_customAddressController.text.isNotEmpty) {
                                setState(
                                  () {
                                    _selectedAddressType = 'Custom';
                                    _addresses['Custom'] = _customAddressController.text;
                                    _showAddressOptions = false;
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    // ================= CATATAN =================
                    Text(
                      'Tambah catatan',
                      style: AppTextStyles.sectionTitle.copyWith(
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    TextField(
                      maxLines: 4,
                      style: AppTextStyles.body,
                      decoration: InputDecoration(
                        hintText: 'Tulis disini',
                        filled: true,
                        fillColor: AppColors.inputFill,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppSpacing.inputRadius,
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.xxl,
                    ),

                    // ================= BUTTON =================
                    PrimaryButton(
                      label: 'Selanjutnya',
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/order-review',
                          arguments: {
                            ...args,
                            'pickupTime': _formatTime(
                              _pickupTime,
                            ),
                            'deliveryTime': _formatTime(
                              _deliveryTime,
                            ),
                            'address': selectedAddress,
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateField(
    String text,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(
          14,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              text,
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconField(
    String text,
    IconData icon,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(
          14,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            text,
          ),
        ],
      ),
    );
  }
}
