import 'package:comida_ja/app/data/models/base_model.dart';

class Restaurante implements BaseModel {
  Restaurante({
    this.id,
    this.nome,
  });

  @override
  int? id;
  String? nome;

  @override
  Restaurante fromMap(Map<String, dynamic> map) => Restaurante(
        id: map["id"],
        nome: map["nome"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "nome": nome,
      };
}
