// DTO class representing the data transfer object

import '../entitites/cantor_entity.dart';

part 'cantor_validate_mixin.dart';

class CantorDTO with CantorValidate {
  int? id;
  String nome;
  String musica;

  CantorDTO({
    this.id,
    this.nome = '',
    this.musica = '',
  });

  // Method to convert from DTO to Entity
  CantorEntity toEntity() {
    return CantorEntity(
      id: id ?? 0,
      nome: nome,
      musica: musica,
    );
  }

  // Method to convert from JSON to DTO
  factory CantorDTO.fromJson(Map<String, dynamic> json) {
    return CantorDTO(
      id: json['id'] ?? '',
      nome: json['nome'] ?? '',
      musica: json['musica'] ?? '',
    );
  }

  // Method to convert from DTO to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'musica': musica,
    };
  }

  @override
  String toString() {
    return 'CantorDTO(id: $id, nome: $nome, musica: $musica)';
  }

  void validate() {
    nameValidate(nome);
  }
}
