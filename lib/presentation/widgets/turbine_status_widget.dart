import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/turbine_provider.dart';

class TurbineStatusWidget extends ConsumerWidget {
  const TurbineStatusWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final encendidas = ref.watch(turbineProvider);
    final textTheme = Theme.of(context).textTheme;
    final color = encendidas ? Colors.green : Colors.grey;

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
            'Turbinas',
            style: textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 6),
          Icon(Icons.settings, color: color, size: 26),
          const SizedBox(height: 4),
          Text(
            encendidas ? 'Encendidas' : 'Apagadas',
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
