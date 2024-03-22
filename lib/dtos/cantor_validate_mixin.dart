part of 'cantor_dto.dart';

mixin class CantorValidate {
  String? nameValidate(String nome) {
    if (nome.isEmpty) {
      return 'O nome não pode ser vazio';
    }
    return null;
  }

  String? musicaValidate(String sucesso) {
    if (sucesso.isEmpty) {
      return 'O principal sucesso não pode ser vazio';
    }
    return null;
  }
}
