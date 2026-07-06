import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/domain/domain.dart';
import 'coolant_temperature_provider.dart';
import 'reactor_state_provider.dart';
import 'turbine_provider.dart';
import 'ventilation_provider.dart';

const double _temperaturaSegura = 400;

const _pasosIniciales = [
  ShutdownStepEntity(
    id: ShutdownStepId.detenerTurbinas,
    orden: 1,
    nombre: 'Detener turbinas',
  ),
  ShutdownStepEntity(
    id: ShutdownStepId.ventilarNucleo,
    orden: 2,
    nombre: 'Ventilar nucleo',
  ),
  ShutdownStepEntity(
    id: ShutdownStepId.estabilizarAgua,
    orden: 3,
    nombre: 'Estabilizar agua',
  ),
  ShutdownStepEntity(
    id: ShutdownStepId.apagarReactor,
    orden: 4,
    nombre: 'Apagar reactor',
  ),
  ShutdownStepEntity(
    id: ShutdownStepId.paradaEmergencia,
    orden: 5,
    nombre: 'Parada de emergencia',
  ),
];

class ShutdownSequenceState {
  final List<ShutdownStepEntity> pasos;
  final String? mensajeError;

  const ShutdownSequenceState({required this.pasos, this.mensajeError});

  bool get completadaCorrectamente =>
      pasos.every((paso) => paso.status == StepStatus.completado);

  bool get primerosCuatroCompletados => pasos
      .where((paso) => paso.id != ShutdownStepId.paradaEmergencia)
      .every((paso) => paso.status == StepStatus.completado);

  ShutdownSequenceState copyWith({
    List<ShutdownStepEntity>? pasos,
    String? mensajeError,
  }) {
    return ShutdownSequenceState(
      pasos: pasos ?? this.pasos,
      mensajeError: mensajeError,
    );
  }
}

final shutdownSequenceProvider =
    NotifierProvider.autoDispose<
      ShutdownSequenceNotifier,
      ShutdownSequenceState
    >(ShutdownSequenceNotifier.new);

class ShutdownSequenceNotifier extends Notifier<ShutdownSequenceState> {
  @override
  ShutdownSequenceState build() {
    ref.listen(turbineProvider, (previous, next) => _reevaluar());
    ref.listen(ventilationProvider, (previous, next) => _reevaluar());
    ref.listen(coolantTemperatureProvider, (previous, next) => _reevaluar());
    ref.listen(reactorStateProvider, (previous, next) => _reevaluar());

    return const ShutdownSequenceState(pasos: _pasosIniciales);
  }

  ShutdownStepId? _primerPendiente(List<ShutdownStepEntity> pasos) {
    for (final paso in pasos) {
      if (paso.id == ShutdownStepId.paradaEmergencia) continue;
      if (paso.status != StepStatus.completado) return paso.id;
    }
    return null;
  }

  void _reevaluar() {
    final condiciones = <ShutdownStepId, bool>{
      ShutdownStepId.detenerTurbinas: !ref.read(turbineProvider),
      ShutdownStepId.ventilarNucleo: ref.read(ventilationProvider),
      ShutdownStepId.estabilizarAgua:
          ref.read(coolantTemperatureProvider) <= _temperaturaSegura,
      ShutdownStepId.apagarReactor:
          ref.read(reactorStateProvider).estado == ReactorPowerState.apagado,
    };

    final pasos = List<ShutdownStepEntity>.of(state.pasos);
    String? mensajeError;

    for (final entrada in condiciones.entries) {
      final index = pasos.indexWhere((paso) => paso.id == entrada.key);
      final paso = pasos[index];

      if (paso.status == StepStatus.completado) continue;

      if (!entrada.value) {
        if (paso.status == StepStatus.error) {
          pasos[index] = paso.copyWith(status: StepStatus.pendiente);
        }
        continue;
      }

      if (entrada.key == _primerPendiente(pasos)) {
        pasos[index] = paso.copyWith(status: StepStatus.completado);
      } else {
        pasos[index] = paso.copyWith(status: StepStatus.error);
        mensajeError = 'Accion fuera de orden: revisa la secuencia correcta.';
      }
    }

    state = state.copyWith(pasos: pasos, mensajeError: mensajeError);
  }

  void confirmarEmergencia() {
    final todosCompletos = state.primerosCuatroCompletados;

    final pasos = state.pasos.map((paso) {
      if (paso.id != ShutdownStepId.paradaEmergencia) return paso;
      return paso.copyWith(
        status: todosCompletos ? StepStatus.completado : StepStatus.error,
      );
    }).toList();

    state = state.copyWith(
      pasos: pasos,
      mensajeError: todosCompletos
          ? null
          : 'Completa los pasos 1 a 4 antes de la parada de emergencia.',
    );
  }
}
