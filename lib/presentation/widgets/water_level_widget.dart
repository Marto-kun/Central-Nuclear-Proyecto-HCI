import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/water_level_provider.dart';

class WaterLevelWidget extends ConsumerWidget {
  const WaterLevelWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nivel = ref.watch(waterLevelProvider);
    final textTheme = Theme.of(context).textTheme;

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
            'Nivel de Agua',
            style: textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: nivel / 100,
              minHeight: 8,
              backgroundColor: Colors.white12,
              color: Colors.lightBlue,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${nivel.toStringAsFixed(0)} %',
            style: textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
