import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/water_level_provider.dart';
import 'filled_button_widget.dart';

class SendWaterButtonWidget extends ConsumerWidget {
  const SendWaterButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButtonWidget(
      width: 0.16,
      height: 0.11,
      onPressed: () => ref.read(waterLevelProvider.notifier).enviarAgua(),
      borderRadiusValue: 10,
      colorButton: Colors.blue.shade800,
      textButton: 'Enviar Agua',
      iconButton: Icons.water_drop,
      colorText: Colors.white,
      colorIcon: Colors.white,
    );
  }
}
