import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shutdown_sequence_provider.dart';

enum EmergencyButtonState { bloqueado, disponible, confirmacionPendiente }

final emergencyButtonProvider =
    NotifierProvider.autoDispose<
      EmergencyButtonNotifier,
      EmergencyButtonState
    >(EmergencyButtonNotifier.new);

class EmergencyButtonNotifier extends Notifier<EmergencyButtonState> {
  @override
  EmergencyButtonState build() {
    ref.listen(shutdownSequenceProvider, (previous, next) {
      if (state == EmergencyButtonState.confirmacionPendiente) return;
      state = next.primerosCuatroCompletados
          ? EmergencyButtonState.disponible
          : EmergencyButtonState.bloqueado;
    });

    final estadoActual = ref.read(shutdownSequenceProvider);
    return estadoActual.primerosCuatroCompletados
        ? EmergencyButtonState.disponible
        : EmergencyButtonState.bloqueado;
  }

  void solicitarConfirmacion() {
    if (state != EmergencyButtonState.disponible) {
      ref.read(shutdownSequenceProvider.notifier).confirmarEmergencia();
      return;
    }
    state = EmergencyButtonState.confirmacionPendiente;
  }

  void cancelar() {
    state = ref.read(shutdownSequenceProvider).primerosCuatroCompletados
        ? EmergencyButtonState.disponible
        : EmergencyButtonState.bloqueado;
  }

  void confirmar() {
    ref.read(shutdownSequenceProvider.notifier).confirmarEmergencia();
    state = EmergencyButtonState.disponible;
  }
}
