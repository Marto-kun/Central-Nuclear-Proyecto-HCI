import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:central_nuclear/presentation/providers/coolant_temperature_provider.dart';
import 'package:central_nuclear/presentation/providers/count_seconds_provider.dart';
import 'package:central_nuclear/presentation/providers/emergency_button_provider.dart';
import 'package:central_nuclear/presentation/providers/energy_output_provider.dart';
import 'package:central_nuclear/presentation/providers/reactor_state_provider.dart';
import 'package:central_nuclear/presentation/providers/shutdown_sequence_provider.dart';
import 'package:central_nuclear/presentation/providers/simulation_result_provider.dart';
import 'package:central_nuclear/presentation/providers/turbine_provider.dart';
import 'package:central_nuclear/presentation/providers/ventilation_provider.dart';
import 'package:central_nuclear/presentation/providers/water_level_provider.dart';
import 'package:central_nuclear/presentation/widgets/widgets.dart';

class LoseScreen extends ConsumerWidget {
  const LoseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.dangerous, color: Colors.red, size: size.width * 0.12),
            SizedBox(height: size.height * 0.02),
            Text(
              'NUCLEO COLAPSADO',
              style: textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              'No se completo la secuencia de parada a tiempo.',
              style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            SizedBox(height: size.height * 0.04),
            FilledButtonWidget(
              width: 0.4,
              height: 0.08,
              onPressed: () => _reiniciar(context, ref),
              borderRadiusValue: 10,
              colorButton: Colors.red.shade800,
              textButton: 'Reiniciar',
              iconButton: Icons.refresh,
              colorText: Colors.white,
              colorIcon: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  void _reiniciar(BuildContext context, WidgetRef ref) {
    ref.invalidate(countSeconsStreamProvider);
    ref.invalidate(waterLevelProvider);
    ref.invalidate(coolantTemperatureProvider);
    ref.invalidate(reactorStateProvider);
    ref.invalidate(energyOutputProvider);
    ref.invalidate(turbineProvider);
    ref.invalidate(ventilationProvider);
    ref.invalidate(shutdownSequenceProvider);
    ref.invalidate(emergencyButtonProvider);
    ref.invalidate(simulationResultProvider);
    context.go('/');
  }
}
