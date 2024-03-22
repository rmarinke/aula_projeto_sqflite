import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Conexao {
  static const _dbname = "musica.db";
  static const _sqlScript =
      'CREATE TABLE cantor(id INTEGER PRIMARY KEY AUTOINCREMENT,nome TEXT, musica TEXT)';

  static const table = 'cantor';
  static const columnId = 'id';
  static const columnNome = 'nome';
  static const columnMusica = 'musica';

  //singleton
  Conexao._privateConstructor();
  static final Conexao instance = Conexao._privateConstructor();
  // tem somente uma referência ao banco de dados - com safenull
  static Database? _database;

  Future<Database> get database async {
    return _database ??= await initDB();
  }

  Future<Database> initDB() async {
    // instancia o db na primeira vez que for acessado
    return openDatabase(
      join(await getDatabasesPath(), _dbname),
      onCreate: (db, version) {
        return db.execute(_sqlScript);
      },
      version: 1,
    );
  }

  Future<Database> getDatabase() async {
    // instancia o db na primeira vez que for acessado
    return openDatabase(
      join(await getDatabasesPath(), _dbname),
      onCreate: (db, version) {
        return db.execute(_sqlScript);
      },
      version: 1,
    );
  }
}
