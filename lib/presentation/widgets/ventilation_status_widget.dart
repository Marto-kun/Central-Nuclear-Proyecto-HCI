import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ventilation_provider.dart';

class VentilationStatusWidget extends ConsumerWidget {
  const VentilationStatusWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final encendida = ref.watch(ventilationProvider);
    final textTheme = Theme.of(context).textTheme;
    final color = encendida ? Colors.green : Colors.grey;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        border: Border.all(color: Colors.white24),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Ventilacion',
            style: textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 6),
          Icon(Icons.air, color: color, size: 26),
          const SizedBox(height: 4),
          Text(
            encendida ? 'Encendida' : 'Apagada',
            style: textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
