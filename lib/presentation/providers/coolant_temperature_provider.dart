import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/domain/domain.dart';
import 'count_seconds_provider.dart';
import 'reactor_state_provider.dart';

final coolantTemperatureProvider =
    NotifierProvider.autoDispose<CoolantTemperatureNotifier, double>(
      CoolantTemperatureNotifier.new,
    );

class CoolantTemperatureNotifier extends Notifier<double> {
  static const double _subidaEncendido = 8;
  static const double _subidaApagado = 2;
  static const double _temperaturaMaxima = 700;

  @override
  double build() {
    ref.listen(countSeconsStreamProvider, (previous, next) {
      next.whenData((_) => _avanzarTick());
    });

    return 300;
  }

  void _avanzarTick() {
    final reactor = ref.read(reactorStateProvider);
    final incremento = reactor.estado == ReactorPowerState.encendido
        ? _subidaEncendido
        : _subidaApagado;

    state = (state + incremento).clamp(0, _temperaturaMaxima).toDouble();
  }

  void enfriar(double delta) {
    state = (state - delta).clamp(0, _temperaturaMaxima).toDouble();
  }
}
