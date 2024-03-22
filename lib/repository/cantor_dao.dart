import 'package:sqflite/sqflite.dart';

import '../dtos/cantor_dto.dart';
import 'conexao.dart';

class CantorDAO {
  // final Database _db;
  Future<Database> get _db async => await Conexao.instance.database;

  // CantorDAO(this._db);

  Future<void> insert(CantorDTO cantor) async {
    final db = await _db;
    await db.insert('cantor', cantor.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(CantorDTO cantorDTO) async {
    final db = await _db;
    await db.update(
      'cantor',
      cantorDTO.toMap(),
      where: 'id = ?',
      whereArgs: [cantorDTO.id],
    );
  }

  Future<void> delete(String id) async {
    final db = await _db;
    await db.delete(
      'cantor',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<CantorDTO?> selectById(String id) async {
    final db = await _db;
    List<Map<String, dynamic>> maps = await db.query(
      'cantor',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return CantorDTO(
        id: maps[0]['id'],
        nome: maps[0]['nome'],
        musica: maps[0]['musica'],
      );
    } else {
      return null;
    }
  }

  Future<List<CantorDTO>> selectAll() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query('cantor');
    return List.generate(maps.length, (i) {
      return CantorDTO(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        musica: maps[i]['musica'],
      );
    });
  }

  Future<CantorDTO> obterUltimo() async {
    try {
      final db = await _db;

      // Query the database to get the last inserted record based on the primary key
      List<Map<String, dynamic>> maps =
          await db.rawQuery('SELECT * FROM cantor ORDER BY id DESC LIMIT 1');

      if (maps.isNotEmpty) {
        return CantorDTO(
          id: maps[0]['id'],
          nome: maps[0]['nome'],
          musica: maps[0]['musica'],
        );
      } else {
        return CantorDTO(id: 0, nome: '', musica: '');
      }
    } catch (e) {
      print('Erro: $e');
      return CantorDTO(id: 0, nome: '', musica: '');
    }
  }
}
