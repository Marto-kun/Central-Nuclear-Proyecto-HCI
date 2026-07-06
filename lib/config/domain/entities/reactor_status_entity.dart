enum ReactorPowerState { encendido, apagado }

class ReactorStatusEntity {
  final ReactorPowerState estado;
  final double temperaturaNucleo;
  final double potencia;

  const ReactorStatusEntity({
    required this.estado,
    required this.temperaturaNucleo,
    required this.potencia,
  });

  ReactorStatusEntity copyWith({
    ReactorPowerState? estado,
    double? temperaturaNucleo,
    double? potencia,
  }) {
    return ReactorStatusEntity(
      estado: estado ?? this.estado,
      temperaturaNucleo: temperaturaNucleo ?? this.temperaturaNucleo,
      potencia: potencia ?? this.potencia,
    );
  }
}
