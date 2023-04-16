import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'note.dart';

class NoteService {
  static final NoteService instance = NoteService._sharedInstance();
  NoteService._sharedInstance();

  Database? _notesDatabase;

  Future<Database> get _getOrInitDatabase async {
    if (_notesDatabase != null) {
      return _notesDatabase!;
    } else {
      _notesDatabase = await _initDatabase('notes.db');
      return _notesDatabase!;
    }
  }

  Future<Database> _initDatabase(String fileName) async {
    final databasePath = await getDatabasesPath();
    final filePath = join(databasePath, fileName);
    return await openDatabase(
      filePath,
      version: 1,
      onCreate: _createNotesTable,
    );
  }

  Future<void> _createNotesTable(Database db, int version) async {
    await db.execute('''CREATE TABLE notes (
        id TEXT PRIMARY KEY NOT NULL,
        title TEXT,
        content TEXT,
        dateTime TEXT,
        color TEXT
      )''');
  }

  Future<List<Note>> getNotes() async {
    final db = await _getOrInitDatabase;
    final result = await db.query('notes');
    return result.map((e) => Note.fromJson(e)).toList();
  }

  Future<void> addNotes(Note note) async {
    final db = await _getOrInitDatabase;
    await db.insert('notes', note.toJson());
  }

  Future<void> updateNote(Note note) async {
    final db = await _getOrInitDatabase;
    await db.update(
      'notes',
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote(int id) async {
    final db = await _getOrInitDatabase;
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAll() async {
    final db = await _getOrInitDatabase;
    await db.delete('notes');
  }

  Future<void> deleteTable() async {
    final db = await _getOrInitDatabase;
    await db.execute('DROP TABLE IF EXISTS notes');
  }
}
