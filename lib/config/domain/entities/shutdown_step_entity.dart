enum StepStatus { pendiente, activo, completado, error }

enum ShutdownStepId {
  detenerTurbinas,
  ventilarNucleo,
  estabilizarAgua,
  apagarReactor,
  paradaEmergencia,
}

class ShutdownStepEntity {
  final ShutdownStepId id;
  final int orden;
  final String nombre;
  final StepStatus status;

  const ShutdownStepEntity({
    required this.id,
    required this.orden,
    required this.nombre,
    this.status = StepStatus.pendiente,
  });

  ShutdownStepEntity copyWith({StepStatus? status}) {
    return ShutdownStepEntity(
      id: id,
      orden: orden,
      nombre: nombre,
      status: status ?? this.status,
    );
  }
}
