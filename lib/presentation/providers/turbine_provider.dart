import 'package:flutter_riverpod/flutter_riverpod.dart';

final turbineProvider = NotifierProvider.autoDispose<TurbineNotifier, bool>(
  TurbineNotifier.new,
);

class TurbineNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void alternar() => state = !state;
}
