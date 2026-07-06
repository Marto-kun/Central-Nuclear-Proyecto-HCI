import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ventilation_provider.dart';
import 'filled_button_widget.dart';

class VentilationToggleButtonWidget extends ConsumerWidget {
  const VentilationToggleButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final encendida = ref.watch(ventilationProvider);

    return FilledButtonWidget(
      width: 0.16,
      height: 0.11,
      onPressed: () => ref.read(ventilationProvider.notifier).alternar(),
      borderRadiusValue: 10,
      colorButton: encendida ? Colors.green.shade800 : Colors.grey.shade700,
      textButton: encendida ? 'Apagar Ventilacion' : 'Encender Ventilacion',
      iconButton: Icons.air,
      colorText: Colors.white,
      colorIcon: Colors.white,
    );
  }
}
