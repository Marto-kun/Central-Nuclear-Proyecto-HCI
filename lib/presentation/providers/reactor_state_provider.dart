import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/domain/domain.dart';
import 'count_seconds_provider.dart';

final reactorStateProvider =
    NotifierProvider.autoDispose<ReactorStateNotifier, ReactorStatusEntity>(
      ReactorStateNotifier.new,
    );

class ReactorStateNotifier extends Notifier<ReactorStatusEntity> {
  static const double _subidaPorTick = 6;
  static const double _bajadaPorTick = 10;
  static const double _temperaturaMaxima = 900;

  @override
  ReactorStatusEntity build() {
    ref.listen(countSeconsStreamProvider, (previous, next) {
      next.whenData((_) => _avanzarTick());
    });

    return const ReactorStatusEntity(
      estado: ReactorPowerState.encendido,
      temperaturaNucleo: 320,
      potencia: 100,
    );
  }

  void _avanzarTick() {
    final delta = state.estado == ReactorPowerState.encendido
        ? _subidaPorTick
        : -_bajadaPorTick;

    final nuevaTemperatura = (state.temperaturaNucleo + delta).clamp(
      0,
      _temperaturaMaxima,
    );

    state = state.copyWith(
      temperaturaNucleo: nuevaTemperatura.toDouble(),
      potencia: (nuevaTemperatura / _temperaturaMaxima * 100)
          .clamp(0, 100)
          .toDouble(),
    );
  }

  void apagarReactor() {
    state = state.copyWith(estado: ReactorPowerState.apagado);
  }
}
