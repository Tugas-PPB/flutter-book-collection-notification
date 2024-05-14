import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:firebase_test_app/model/book.dart';

class BooksDatabase {
  static final BooksDatabase instance = BooksDatabase._init();

  static Database? _database;

  BooksDatabase._init();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDB('books.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // await deleteDatabase(path);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    // const integerType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableBooks (
      ${BookFields.id} $idType,
      ${BookFields.title} $textType,
      ${BookFields.coverImageUrl} $textType,
      ${BookFields.description} $textType,
      ${BookFields.createdTime} $textType
    )
    ''');
  }

  Future<Book> create(Book note) async {
    final db = await instance.database;
    final id = await db.insert(tableBooks, note.toJson());
    return note.copy(id: id);
  }

  Future<Book> readBook(int id) async {
    final db = await instance.database;
    // whereArgs helps prevent sql injection
    final maps = await db.query(
      tableBooks,
      columns: BookFields.values,
      where: '${BookFields.id} = ?',
      whereArgs: [id],
    );
    
    if (maps.isEmpty) throw Exception('ID $id is not found');
    return Book.fromJson(maps[0]);
  }

  Future<List<Book>> readAllBooks() async {
    final db = await instance.database;
    final result = await db.query(tableBooks);
    return result.map((note) => Book.fromJson(note)).toList();
  }

  Future<int> update(Book note) async {
    final db = await instance.database;

    print(note.toJson());

    return await db.update(
      tableBooks,
      note.toJson(),
      where: '${BookFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableBooks,
      where: '${BookFields.id} = ?',
      whereArgs: [id]
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}