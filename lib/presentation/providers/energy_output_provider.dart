import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/domain/domain.dart';
import 'reactor_state_provider.dart';

final energyOutputProvider = Provider.autoDispose<double>((ref) {
  final reactor = ref.watch(reactorStateProvider);

  if (reactor.estado == ReactorPowerState.apagado) return 0;

  return (reactor.temperaturaNucleo * 2.2).clamp(0, 1200).toDouble();
});
