import 'package:exam/model/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final dbName = 'userApp.db';
  final dbVersion = 1;
  final tableName = 'notes';

  final id = 'id';
  final notes = 'Notes';

  DatabaseHelper._();
  static final DatabaseHelper databaseHelper = DatabaseHelper._();

  static Database? dataBase;

  Future<Database> get database async {
    if (dataBase != null) return dataBase!;
    dataBase = await initDatabase();
    return dataBase!;
  }

  Future onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        $id INTEGER PRIMARY KEY AUTOINCREMENT,
        $notes TEXT NOT NULL
      )
    ''');
  }

  initDatabase() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(path, version: dbVersion, onCreate: onCreate);
  }

  Future<int> insert({required String note}) async {
    Database db = await databaseHelper.database;

    Map<String, dynamic> row = {
      notes: note,
    };
    return await db.insert(tableName, row);
  }

  Future<List<NoteModel>> fetchData() async {
    Database database = await databaseHelper.database;
    String query = "SELECT * FROM $tableName";
    List<Map<String, Object?>> allData = await database.rawQuery(query);
    return allData.map((e) => NoteModel.fromJson(e)).toList();
  }

  Future<int?> deleteData(int iD) async {
    Database? db = await databaseHelper.database;
    String query = "DELETE FROM $tableName WHERE $id = $iD";
    return await db.rawDelete(query);
  }
}
