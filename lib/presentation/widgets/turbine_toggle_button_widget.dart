import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/turbine_provider.dart';
import 'filled_button_widget.dart';

class TurbineToggleButtonWidget extends ConsumerWidget {
  const TurbineToggleButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final encendidas = ref.watch(turbineProvider);

    return FilledButtonWidget(
      width: 0.16,
      height: 0.11,
      onPressed: () => ref.read(turbineProvider.notifier).alternar(),
      borderRadiusValue: 10,
      colorButton: encendidas ? Colors.green.shade800 : Colors.grey.shade700,
      textButton: encendidas ? 'Apagar Turbinas' : 'Encender Turbinas',
      iconButton: Icons.settings,
      colorText: Colors.white,
      colorIcon: Colors.white,
    );
  }
}
