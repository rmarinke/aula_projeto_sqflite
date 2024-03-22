import 'dart:math';

import 'package:flutter/material.dart';

class ItensLista extends StatelessWidget {
  final String _titulo;
  final String _subTitulo;

  const ItensLista(this._titulo, this._subTitulo, {super.key});

  @override
  Widget build(Object context) {
    return Card(
      child: ListTile(
        tileColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        leading: const Icon(Icons.music_note),
        title: Text(_titulo),
        subtitle: Text(_subTitulo),
      ),
    );
  }
}
