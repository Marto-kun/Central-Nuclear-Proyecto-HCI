import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/water_level_provider.dart';
import 'filled_button_widget.dart';

class VentWaterButtonWidget extends ConsumerWidget {
  const VentWaterButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButtonWidget(
      width: 0.16,
      height: 0.11,
      onPressed: () => ref.read(waterLevelProvider.notifier).desfogarAgua(),
      borderRadiusValue: 10,
      colorButton: Colors.blueGrey.shade700,
      textButton: 'Desfogar Agua',
      iconButton: Icons.water_drop_outlined,
      colorText: Colors.white,
      colorIcon: Colors.white,
    );
  }
}
