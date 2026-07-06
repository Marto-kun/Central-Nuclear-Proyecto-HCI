import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/coolant_temperature_provider.dart';

class CoolantTemperatureWidget extends ConsumerStatefulWidget {
  const CoolantTemperatureWidget({super.key});

  @override
  ConsumerState<CoolantTemperatureWidget> createState() =>
      _CoolantTemperatureWidgetState();
}

class _CoolantTemperatureWidgetState
    extends ConsumerState<CoolantTemperatureWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const double _umbralAlerta = 400;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final temperatura = ref.watch(coolantTemperatureProvider);
    final enAlerta = temperatura > _umbralAlerta;
    final textTheme = Theme.of(context).textTheme;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final colorValor = enAlerta
            ? Color.lerp(
                Colors.red.shade900,
                Colors.red.shade300,
                _controller.value,
              )!
            : Colors.white;

        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            border: Border.all(color: enAlerta ? Colors.red : Colors.white24),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Temperatura Refrigerante',
                style: textTheme.bodySmall?.copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: (temperatura / 500).clamp(0, 1),
                  minHeight: 8,
                  backgroundColor: Colors.white12,
                  color: enAlerta ? Colors.red : Colors.lightBlue,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${temperatura.toStringAsFixed(0)} C',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorValor,
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
