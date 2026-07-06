import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'coolant_temperature_provider.dart';
import 'count_seconds_provider.dart';
import 'shutdown_sequence_provider.dart';

const double _temperaturaCritica = 500;

enum SimulationResult { enCurso, victoria, derrotaTiempo, derrotaTemperatura }

final simulationResultProvider =
    NotifierProvider.autoDispose<SimulationResultNotifier, SimulationResult>(
      SimulationResultNotifier.new,
    );

class SimulationResultNotifier extends Notifier<SimulationResult> {
  @override
  SimulationResult build() {
    ref.listen(coolantTemperatureProvider, (previous, next) {
      if (state == SimulationResult.enCurso && next > _temperaturaCritica) {
        state = SimulationResult.derrotaTemperatura;
      }
    });

    ref.listen(shutdownSequenceProvider, (previous, next) {
      if (state == SimulationResult.enCurso && next.completadaCorrectamente) {
        state = SimulationResult.victoria;
      }
    });

    ref.listen(countSeconsStreamProvider, (previous, next) {
      next.whenData((segundos) {
        if (state == SimulationResult.enCurso && segundos <= 0) {
          state = SimulationResult.derrotaTiempo;
        }
      });
    });

    return SimulationResult.enCurso;
  }
}
