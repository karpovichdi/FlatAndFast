import 'package:flat_and_fast/common/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteService {
  static final SQLiteService instance = SQLiteService._init();

  static Database? _database;

  SQLiteService._init();

  Future<Database> get database async {
    return _database ??= await _initDb('notesDb');
  }

  Future<Database> _initDb(String filePath) async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';

    await db.execute('''CREATE TABLE $tableNotes (
    ${NoteFields.id} $idType,
    ${NoteFields.isImportant} $boolType,
    ${NoteFields.number} $integerType,
    ${NoteFields.title} $textType,
    ${NoteFields.description} $textType,
    ${NoteFields.time} $textType)
    ''');
  }

  Future<Note> create(Note note) async {
    var db = await instance.database;
    var json = note.toJson();

    // final id = await _rawSQLInsert(json, db);

    final id = await db.insert(tableNotes, json);
    return note.copy(id: id);
  }

  Future close() async {
    final db = await instance.database;
    db.close;
  }

  Future<Note> readNote(int id) async {
    var db = await instance.database;

    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id is not found');
    }
  }

  Future<List<Note>> readAllNotes() async {
    var db = await instance.database;
    const orderByProperty = '${NoteFields.time} ASC';

    // final result = await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderByProperty');

    var result = await db.query(tableNotes, orderBy: orderByProperty);
    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> update(Note note) async {
    var db = await instance.database;
    return db.update(
      tableNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    var db = await instance.database;
    return db.delete(
      tableNotes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> _rawSQLInsert(Map<String, Object?> json, Database db) async {
    const columns = '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    final values = '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    return await db.rawInsert('INSERT INTO $tableNotes ($columns) VALUES ($values)');
  }
}

const String tableNotes = 'notes';

class NoteFields {
  static const String id = '_id';
  static const String isImportant = 'isImportant';
  static const String number = 'number';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';

  static const List<String> values = [id, isImportant, number, title, description, time];
}
