import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/energy_output_provider.dart';

class EnergyOutputWidget extends ConsumerWidget {
  const EnergyOutputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mwe = ref.watch(energyOutputProvider);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.greenAccent.shade700),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Nivel Energia (MWe)',
            style: textTheme.bodySmall?.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            mwe.toStringAsFixed(0),
            style: textTheme.headlineSmall?.copyWith(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}
