import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:central_nuclear/presentation/providers/shutdown_sequence_provider.dart';
import 'package:central_nuclear/presentation/providers/simulation_result_provider.dart';
import 'package:central_nuclear/presentation/widgets/widgets.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(simulationResultProvider, (previous, next) {
      final yaTerminada = previous != null && previous != SimulationResult.enCurso;
      if (yaTerminada || next == SimulationResult.enCurso) return;

      if (next == SimulationResult.victoria) {
        context.go('/win');
      } else {
        context.go('/lose');
      }
    });

    ref.listen(shutdownSequenceProvider, (previous, next) {
      final mensaje = next.mensajeError;
      if (mensaje == null || mensaje == previous?.mensajeError) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(mensaje)));
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(flex: 1, child: _ControlsColumn()),
              const SizedBox(width: 8),
              Expanded(flex: 3, child: _PanelColumn()),
            ],
          ),
        ),
      ),
    );
  }
}

class _ControlsColumn extends StatelessWidget {
  const _ControlsColumn();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        SendWaterButtonWidget(),
        VentWaterButtonWidget(),
        TurbineToggleButtonWidget(),
        VentilationToggleButtonWidget(),
        ReactorToggleButtonWidget(),
        EmergencyButtonWidget(),
      ],
    );
  }
}

class _PanelColumn extends StatelessWidget {
  const _PanelColumn();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _TopRow()),
        const SizedBox(height: 8),
        Expanded(child: _MiddleRow()),
        const SizedBox(height: 8),
        Expanded(child: _BottomRow()),
      ],
    );
  }
}

class _TopRow extends StatelessWidget {
  const _TopRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: WaterLevelWidget()),
        SizedBox(width: 8),
        Expanded(child: VentilationStatusWidget()),
        SizedBox(width: 8),
        Expanded(child: ReactorCoreTempWidget()),
        SizedBox(width: 8),
        Expanded(child: TurbineStatusWidget()),
      ],
    );
  }
}

class _MiddleRow extends StatelessWidget {
  const _MiddleRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: CoolantTemperatureWidget()),
        SizedBox(width: 8),
        Expanded(child: ReactorPowerWidget()),
        SizedBox(width: 8),
        Expanded(child: EnergyOutputWidget()),
      ],
    );
  }
}

class _BottomRow extends StatelessWidget {
  const _BottomRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(flex: 1, child: CountdownTimerWidget()),
        SizedBox(width: 8),
        Expanded(flex: 3, child: StepsChecklistWidget()),
      ],
    );
  }
}
