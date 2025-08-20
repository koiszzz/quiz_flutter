import 'package:path/path.dart';
import 'package:quiz_flutter/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = "QuizApp.db";
  static const _databaseVersion = 1;

  // Tables
  static const tableBanks = 'banks';
  static const tableQuestions = 'questions';
  static const tableRecords = 'records';
  static const tableFavorites = 'favorites';

  // Bank Columns
  static const columnBankId = 'id';
  static const columnBankName = 'name';
  static const columnBankDescription = 'description';
  static const columnBankCreatedAt = 'created_at';

  // Question Columns
  static const columnQuestionId = 'id';
  static const columnQuestionContent = 'content';
  static const columnQuestionType = 'type';
  static const columnQuestionOptions = 'options';
  static const columnQuestionAnswer = 'answer';
  static const columnQuestionExplanation = 'explanation';
  static const columnQuestionTags = 'tags';
  static const columnQuestionBankId = 'bank_id';
  static const columnQuestionCreatedAt = 'created_at';

  // Record Columns
  static const columnRecordId = 'id';
  static const columnRecordQuestionId = 'question_id';
  static const columnRecordUserAnswer = 'user_answer';
  static const columnRecordIsCorrect = 'is_correct';
  static const columnRecordTimestamp = 'timestamp';
  static const columnRecordMode = 'mode';

  // Favorite Columns
  static const columnFavoriteId = 'id';
  static const columnFavoriteQuestionId = 'question_id';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableBanks (
            $columnBankId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnBankName TEXT NOT NULL,
            $columnBankDescription TEXT,
            $columnBankCreatedAt TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableQuestions (
            $columnQuestionId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnQuestionContent TEXT NOT NULL,
            $columnQuestionType TEXT NOT NULL,
            $columnQuestionOptions TEXT NOT NULL,
            $columnQuestionAnswer TEXT NOT NULL,
            $columnQuestionExplanation TEXT,
            $columnQuestionTags TEXT,
            $columnQuestionBankId INTEGER NOT NULL,
            $columnQuestionCreatedAt TEXT NOT NULL,
            FOREIGN KEY ($columnQuestionBankId) REFERENCES $tableBanks ($columnBankId) ON DELETE CASCADE
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableRecords (
            $columnRecordId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnRecordQuestionId INTEGER NOT NULL,
            $columnRecordUserAnswer TEXT NOT NULL,
            $columnRecordIsCorrect INTEGER NOT NULL,
            $columnRecordTimestamp TEXT NOT NULL,
            $columnRecordMode TEXT NOT NULL,
            FOREIGN KEY ($columnRecordQuestionId) REFERENCES $tableQuestions ($columnQuestionId) ON DELETE CASCADE
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableFavorites (
            $columnFavoriteId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnFavoriteQuestionId INTEGER NOT NULL,
            FOREIGN KEY ($columnFavoriteQuestionId) REFERENCES $tableQuestions ($columnQuestionId) ON DELETE CASCADE
          )
          ''');
  }

  // Bank CRUD
  Future<int> insertBank(QuestionBank bank) async {
    final db = await instance.database;
    return await db.insert(tableBanks, bank.toJson());
  }

  Future<List<QuestionBank>> getAllBanks() async {
    final db = await instance.database;
    final maps = await db.query(tableBanks);
    return List.generate(maps.length, (i) {
      return QuestionBank.fromJson(maps[i]);
    });
  }

  Future<int> updateBank(QuestionBank bank) async {
    final db = await instance.database;
    return await db.update(
      tableBanks,
      bank.toJson(),
      where: '$columnBankId = ?',
      whereArgs: [bank.id],
    );
  }

  Future<int> deleteBank(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableBanks,
      where: '$columnBankId = ?',
      whereArgs: [id],
    );
  }

  // Question CRUD
  Future<int> insertQuestion(Question question) async {
    final db = await instance.database;
    return await db.insert(tableQuestions, question.toJson());
  }

  Future<List<Question>> getQuestionsByBank(int bankId) async {
    final db = await instance.database;
    final maps = await db.query(
      tableQuestions,
      where: '$columnQuestionBankId = ?',
      whereArgs: [bankId],
    );
    return List.generate(maps.length, (i) {
      return Question.fromJson(maps[i]);
    });
  }

  Future<int> updateQuestion(Question question) async {
    final db = await instance.database;
    return await db.update(
      tableQuestions,
      question.toJson(),
      where: '$columnQuestionId = ?',
      whereArgs: [question.id],
    );
  }

  Future<int> deleteQuestion(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableQuestions,
      where: '$columnQuestionId = ?',
      whereArgs: [id],
    );
  }

  Future<List<Question>> getQuestionsByIds(List<int> ids) async {
    final db = await instance.database;
    final maps = await db.query(
      tableQuestions,
      where: '$columnQuestionId IN (${ids.map((_) => '?').join(', ')})',
      whereArgs: ids,
    );
    return List.generate(maps.length, (i) {
      return Question.fromJson(maps[i]);
    });
  }

  // Record CRUD
  Future<int> insertRecord(QuizRecord record) async {
    final db = await instance.database;
    return await db.insert(tableRecords, record.toJson());
  }

  Future<List<QuizRecord>> getAllRecords() async {
    final db = await instance.database;
    final maps = await db.query(tableRecords);
    return List.generate(maps.length, (i) {
      return QuizRecord.fromJson(maps[i]);
    });
  }

  // Favorite CRUD
  Future<int> insertFavorite(Favorite favorite) async {
    final db = await instance.database;
    return await db.insert(tableFavorites, favorite.toJson());
  }

  Future<List<Favorite>> getAllFavorites() async {
    final db = await instance.database;
    final maps = await db.query(tableFavorites);
    return List.generate(maps.length, (i) {
      return Favorite.fromJson(maps[i]);
    });
  }

  Future<int> deleteFavorite(int questionId) async {
    final db = await instance.database;
    return await db.delete(
      tableFavorites,
      where: '$columnFavoriteQuestionId = ?',
      whereArgs: [questionId],
    );
  }
}
