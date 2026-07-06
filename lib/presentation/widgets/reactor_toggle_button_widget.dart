import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/domain/domain.dart';
import '../providers/reactor_state_provider.dart';
import 'filled_button_widget.dart';

class ReactorToggleButtonWidget extends ConsumerWidget {
  const ReactorToggleButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reactor = ref.watch(reactorStateProvider);
    final apagado = reactor.estado == ReactorPowerState.apagado;

    return FilledButtonWidget(
      width: 0.16,
      height: 0.11,
      onPressed: () {
        if (!apagado) ref.read(reactorStateProvider.notifier).apagarReactor();
      },
      borderRadiusValue: 10,
      colorButton: apagado ? Colors.grey.shade700 : Colors.deepOrange.shade800,
      textButton: apagado ? 'Reactor Apagado' : 'Apagar Reactor',
      iconButton: Icons.power_settings_new,
      colorText: Colors.white,
      colorIcon: Colors.white,
    );
  }
}
