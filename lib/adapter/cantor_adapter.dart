/*
Adapter:
 Usage: Adapters are used to convert one interface or data structure into another.
In this context, they can be used to adapt the Entity objects to fit the
requirements of a particular interface or external system.
*/
import 'package:aula04_statefull/entitites/cantor_entity.dart';

class CantorAdapter {
  CantorAdapter._();

  static CantorEntity fromJson(Map<String, dynamic> json) {
    return CantorEntity(
        id: json['id'] ?? '',
        nome: json['nome'] ?? '',
        musica: json['musica'] ?? '');
  }

  static Map<String, dynamic> toJson(CantorEntity model) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = model.id;
    data['nome'] = model.nome;
    data['musica'] = model.musica;
    return data;
  }
}
