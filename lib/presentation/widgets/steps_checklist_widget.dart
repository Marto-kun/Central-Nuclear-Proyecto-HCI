import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/domain/domain.dart';
import '../providers/shutdown_sequence_provider.dart';

class StepsChecklistWidget extends ConsumerWidget {
  const StepsChecklistWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estado = ref.watch(shutdownSequenceProvider);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        border: Border.all(color: Colors.white24),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: estado.pasos
            .map((paso) => _PasoItem(paso: ShutdownStepEntity(id: paso.id, orden: paso.orden, nombre: paso.nombre), textTheme: textTheme))
            .toList(),
      ),
    );
  }
}

class _PasoItem extends StatelessWidget {
  const _PasoItem({required this.paso, required this.textTheme});

  final ShutdownStepEntity paso;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    IconData icono;
    Color color;

    switch (paso.status) {
      case StepStatus.pendiente:
        icono = Icons.radio_button_unchecked;
        color = Colors.grey;
        break;
      case StepStatus.activo:
        icono = Icons.autorenew;
        color = Colors.yellow.shade700;
        break;
      case StepStatus.completado:
        icono = Icons.check_circle;
        color = Colors.green;
        break;
      case StepStatus.error:
        icono = Icons.error;
        color = Colors.red;
        break;
    }

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icono, color: color, size: 20),
          const SizedBox(height: 2),
          Text(
            '${paso.orden}. ${paso.nombre}',
            style: textTheme.bodySmall?.copyWith(color: color),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
