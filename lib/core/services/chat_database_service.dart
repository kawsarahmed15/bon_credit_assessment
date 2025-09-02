import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/chat_models.dart';

class ChatDatabaseService {
  static final ChatDatabaseService _instance = ChatDatabaseService._internal();
  static Database? _database;

  factory ChatDatabaseService() => _instance;

  ChatDatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'chat_history.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE conversations(
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        createdAt INTEGER NOT NULL,
        updatedAt INTEGER NOT NULL,
        messages TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_conversations_updatedAt 
      ON conversations(updatedAt DESC)
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 1) {
      await _onCreate(db, newVersion);
    }
  }

  Future<String> saveConversation(ChatConversation conversation) async {
    final db = await database;

    // Update the updatedAt timestamp
    final updatedConversation = conversation.copyWith(
      updatedAt: DateTime.now(),
    );

    await db.insert(
      'conversations',
      updatedConversation.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return updatedConversation.id;
  }

  Future<List<ChatConversation>> getAllConversations() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'conversations',
      orderBy: 'updatedAt DESC',
    );

    return List.generate(maps.length, (i) {
      return ChatConversation.fromJson(maps[i]);
    });
  }

  Future<ChatConversation?> getConversation(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'conversations',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return ChatConversation.fromJson(maps.first);
    }
    return null;
  }

  Future<void> updateConversationTitle(String id, String newTitle) async {
    final db = await database;
    await db.update(
      'conversations',
      {'title': newTitle, 'updatedAt': DateTime.now().millisecondsSinceEpoch},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteConversation(String id) async {
    final db = await database;
    await db.delete('conversations', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearAllConversations() async {
    final db = await database;
    await db.delete('conversations');
  }

  Future<List<ChatConversation>> searchConversations(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'conversations',
      where: 'title LIKE ? OR messages LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'updatedAt DESC',
    );

    return List.generate(maps.length, (i) {
      return ChatConversation.fromJson(maps[i]);
    });
  }

  Future<int> getConversationCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM conversations');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
