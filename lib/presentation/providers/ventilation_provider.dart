import 'package:flutter_riverpod/flutter_riverpod.dart';

final ventilationProvider =
    NotifierProvider.autoDispose<VentilationNotifier, bool>(
      VentilationNotifier.new,
    );

class VentilationNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void alternar() => state = !state;
}
