import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/flashcard.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'flashcards.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE flashcards (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question TEXT NOT NULL,
        answer TEXT NOT NULL,
        category TEXT NOT NULL DEFAULT 'General'
      )
    ''');

    // Seed with a few starter cards so the app isn't empty on first run.
    final starterCards = [
      {
        'question': 'What is the capital of France?',
        'answer': 'Paris',
        'category': 'Geography'
      },
      {
        'question': 'What does CPU stand for?',
        'answer': 'Central Processing Unit',
        'category': 'Tech'
      },
      {
        'question': '2 + 2 x 2 = ?',
        'answer': '6',
        'category': 'Math'
      },
    ];

    for (final card in starterCards) {
      await db.insert('flashcards', card);
    }
  }

  Future<List<Flashcard>> getAllFlashcards() async {
    final db = await database;
    final result = await db.query('flashcards', orderBy: 'id ASC');
    return result.map((map) => Flashcard.fromMap(map)).toList();
  }

  Future<Flashcard> insertFlashcard(Flashcard flashcard) async {
    final db = await database;
    final id = await db.insert('flashcards', flashcard.toMap()..remove('id'));
    return flashcard.copyWith(id: id);
  }

  Future<int> updateFlashcard(Flashcard flashcard) async {
    final db = await database;
    return await db.update(
      'flashcards',
      flashcard.toMap(),
      where: 'id = ?',
      whereArgs: [flashcard.id],
    );
  }

  Future<int> deleteFlashcard(int id) async {
    final db = await database;
    return await db.delete(
      'flashcards',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}