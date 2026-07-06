import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/count_seconds_provider.dart';

class CountdownTimerWidget extends ConsumerStatefulWidget {
  const CountdownTimerWidget({super.key});

  @override
  ConsumerState<CountdownTimerWidget> createState() =>
      _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends ConsumerState<CountdownTimerWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final segundosAsync = ref.watch(countSeconsStreamProvider);
    final textTheme = Theme.of(context).textTheme;
    final segundos = segundosAsync.asData?.value ?? 30;
    final total = segundos.round();

    final minutos = (total ~/ 60).toString().padLeft(2, '0');
    final segs = (total % 60).toString().padLeft(2, '0');

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        Color color;
        if (total < 5) {
          color = Color.lerp(Colors.red.shade900, Colors.red, _controller.value)!;
        } else if (total < 15) {
          color = Colors.yellow.shade700;
        } else {
          color = Colors.white;
        }

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
                'Temporizador',
                style: textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 6),
              Text(
                '$minutos:$segs',
                style: textTheme.headlineSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
