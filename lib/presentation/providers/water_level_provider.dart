import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'coolant_temperature_provider.dart';

final waterLevelProvider =
    NotifierProvider.autoDispose<WaterLevelNotifier, double>(
      WaterLevelNotifier.new,
    );

class WaterLevelNotifier extends Notifier<double> {
  static const double _delta = 15;

  @override
  double build() => 50;

  void enviarAgua() {
    state = (state + _delta).clamp(0, 100).toDouble();
    ref.read(coolantTemperatureProvider.notifier).enfriar(25);
  }

  void desfogarAgua() {
    state = (state - _delta).clamp(0, 100).toDouble();
    ref.read(coolantTemperatureProvider.notifier).enfriar(15);
  }
}
