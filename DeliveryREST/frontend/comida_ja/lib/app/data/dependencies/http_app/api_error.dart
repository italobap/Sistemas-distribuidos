class ApiError {
  ApiError({
    this.codigo,
    this.mensagem,
    this.timestamp,
  });

  String? codigo;
  String? mensagem;
  DateTime? timestamp;

  factory ApiError.fromMap(Map<String, dynamic> json) => ApiError(
        codigo: json["codigo"],
        mensagem: json["mensagem"],
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toMap() => {
        "codigo": codigo,
        "mensagem": mensagem,
        "timestamp": timestamp?.toIso8601String(),
      };
}
