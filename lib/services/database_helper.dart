import 'dart:developer';

import 'package:path/path.dart';
import 'package:quiz_flutter/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = "QuizApp.db";
  static const _databaseVersion = 4;

  // Tables
  static const tableBanks = 'banks';
  static const tableQuestions = 'questions';
  static const tableRecords = 'records';

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
  static const columnQuestionUpdatedAt = 'updated_at';
  static const columnQuestionIsFavorite = 'is_favorite';
  static const columnQuestionTakingTimes = 'taking_times';
  static const columnQuestionLastTakenAt = 'last_taken_at';
  static const columnQuestionUncorrectTimes = 'uncorrect_times';

  // Record Columns
  static const columnRecordId = 'id';
  static const columnRecordBankId = 'bank_id';
  static const columnRecordAnswer = 'answers';
  static const columnRecordScore = 'score';
  static const columnRecordTotal = 'total';
  static const columnRecordDuration = 'duration';
  static const columnRecordTimestamp = 'timestamp';
  static const columnRecordMode = 'mode';
  static const columnRecordQuestionIds = 'question_ids';

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
      onUpgrade: (db, oldVersion, newVersion) async {
        log('当前系统数据库版本: $oldVersion => $newVersion');
        if (oldVersion < 2) {
          await db.execute('DROP TABLE $tableRecords');
          await db.execute('''
          CREATE TABLE $tableRecords (
            $columnRecordId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnRecordBankId INTEGER NOT NULL,
            $columnRecordAnswer TEXT NOT NULL,
            $columnRecordScore INTEGER NOT NULL,
            $columnRecordDuration INTEGER NOT NULL,
            $columnRecordTimestamp TEXT NOT NULL,
            $columnRecordMode TEXT NOT NULL
          )
          ''');
        } else if (oldVersion < 3) {
          await db.execute(
            'ALTER TABLE $tableQuestions ADD COLUMN $columnQuestionUpdatedAt TEXT NOT NULL DEFAULT ""',
          );
          await db.execute(
            'ALTER TABLE $tableQuestions ADD COLUMN $columnQuestionIsFavorite INTEGER NOT NULL DEFAULT 0',
          );
          await db.execute(
            'ALTER TABLE $tableQuestions ADD COLUMN $columnQuestionTakingTimes INTEGER NOT NULL DEFAULT 0',
          );
          await db.execute(
            'ALTER TABLE $tableQuestions ADD COLUMN $columnQuestionLastTakenAt TEXT NOT NULL DEFAULT ""',
          );
          await db.execute(
            'ALTER TABLE $tableQuestions ADD COLUMN $columnQuestionUncorrectTimes INTEGER NOT NULL DEFAULT 0',
          );
        } else if (oldVersion < 4) {
          await db.execute(
            'ALTER TABLE $tableRecords ADD COLUMN $columnRecordTotal INTEGER NOT NULL DEFAULT 0',
          );
          await db.execute(
            'ALTER TABLE $tableRecords ADD COLUMN $columnRecordQuestionIds TEXT NOT NULL DEFAULT ""',
          );
        }
      },
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
            $columnQuestionUpdatedAt TEXT NOT NULL,
            $columnQuestionIsFavorite INTEGER NOT NULL,
            $columnQuestionTakingTimes INTEGER NOT NULL,
            $columnQuestionLastTakenAt TEXT NOT NULL,
            $columnQuestionUncorrectTimes INTEGER NOT NULL,
            FOREIGN KEY ($columnQuestionBankId) REFERENCES $tableBanks ($columnBankId) ON DELETE CASCADE
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableRecords (
            $columnRecordId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnRecordBankId INTEGER NOT NULL,
            $columnRecordAnswer TEXT NOT NULL,
            $columnRecordScore INTEGER NOT NULL,
            $columnRecordTotal INTEGER NOT NULL,
            $columnRecordDuration INTEGER NOT NULL,
            $columnRecordTimestamp TEXT NOT NULL,
            $columnRecordMode TEXT NOT NULL,
            $columnRecordQuestionIds TEXT NOT NULL
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
    await db.delete(
      tableQuestions,
      where: '$columnQuestionBankId = ?',
      whereArgs: [id],
    );
    await db.delete(
      tableRecords,
      where: '$columnRecordBankId = ?',
      whereArgs: [id],
    );
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

  Future<List<Question>> getQuestionsByBank({
    int bankId = 0,
    bool withFavorites = false,
    bool withoutTaken = false,
    bool onlyFailed = false,
  }) async {
    final db = await instance.database;
    log('''      SELECT * FROM $tableQuestions
      WHERE 1 = 1 ${bankId > 0 ? 'AND $columnQuestionBankId = $bankId' : ''}
      ${withFavorites ? 'AND $columnQuestionIsFavorite = 1' : ''}
      ${withoutTaken ? 'AND $columnQuestionTakingTimes = 0' : ''}
      ${onlyFailed ? 'AND $columnQuestionUncorrectTimes > 0' : ''}''');
    final maps = await db.rawQuery('''
      SELECT * FROM $tableQuestions
      WHERE 1 = 1 ${bankId > 0 ? 'AND $columnQuestionBankId = $bankId' : ''}
      ${withFavorites ? 'AND $columnQuestionIsFavorite = 1' : ''}
      ${withoutTaken ? 'AND $columnQuestionTakingTimes = 0' : ''}
      ${onlyFailed ? 'AND $columnQuestionUncorrectTimes > 0' : ''}
      ''');
    return List.generate(maps.length, (i) {
      return Question.fromJson(maps[i]);
    });
  }

  Future<Map<String, int>> getQuestionCountsByBank(int bankId) async {
    final db = await instance.database;
    final maps = await db.rawQuery(
      '''
      SELECT type, COUNT(*) as count
      FROM $tableQuestions
      WHERE $columnQuestionBankId = ?
      GROUP BY type
      ''',
      [bankId],
    );
    return {
      for (var item in maps) item['type'] as String: item['count'] as int,
    };
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
      where: '$columnQuestionBankId IN (${ids.map((_) => '?').join(', ')})',
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
}
