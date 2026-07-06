import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/emergency_button_provider.dart';
import 'filled_button_widget.dart';

class EmergencyButtonWidget extends ConsumerWidget {
  const EmergencyButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(emergencyButtonProvider);

    return FilledButtonWidget(
      width: 0.2,
      height: 0.13,
      onPressed: () => _onPressed(context, ref),
      borderRadiusValue: 12,
      colorButton: Colors.red.shade800,
      textButton: 'Boton Emergencia',
      iconButton: Icons.warning_amber_rounded,
      colorText: Colors.white,
      colorIcon: Colors.white,
    );
  }

  Future<void> _onPressed(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(emergencyButtonProvider.notifier);
    final estado = ref.read(emergencyButtonProvider);

    if (estado != EmergencyButtonState.disponible) {
      notifier.solicitarConfirmacion();
      return;
    }

    notifier.solicitarConfirmacion();

    final confirmado = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar parada de emergencia'),
        content: const Text(
          'Esta accion detendra el reactor de forma definitiva. Deseas continuar?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );

    if (confirmado == true) {
      notifier.confirmar();
    } else {
      notifier.cancelar();
    }
  }
}
