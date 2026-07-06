import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/reactor_state_provider.dart';

class ReactorCoreTempWidget extends ConsumerWidget {
  const ReactorCoreTempWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reactor = ref.watch(reactorStateProvider);
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
            'Temp. Reactor',
            style: textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 6),
          Text(
            '${reactor.temperaturaNucleo.toStringAsFixed(0)} C',
            style: textTheme.bodyLarge?.copyWith(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
