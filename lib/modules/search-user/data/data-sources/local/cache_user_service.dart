import 'package:github_user_finder/modules/search-user/data/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CacheUserService {
  static final CacheUserService _instance = CacheUserService._internal();
  factory CacheUserService() => _instance;
  CacheUserService._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'users.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE CachedUser (
            login TEXT PRIMARY KEY,
            name TEXT,
            bio TEXT,
            location TEXT,
            followers INTEGER,
            public_repos INTEGER,
            avatar_url TEXT,
            timestamp INTEGER
          )
        ''');
      },
    );
  }

  Future<void> cacheUser(UserModel user) async {
    final db = await database;

    final data = user.toJson();

    data['timestamp'] = DateTime.now().millisecondsSinceEpoch;

    await db.insert(
      'CachedUser',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<UserModel?> getCachedUserByUsername(String username) async {
    final db = await database;
    final result = await db.query(
      'CachedUser',
      where: 'login = ?',
      whereArgs: [username],
    );

    if (result.isNotEmpty) {
      return UserModel.fromJson(result.first);
    }
    return null;
  }

  Future<List<UserModel>> getLastUsers({int limit = 5}) async {
    final db = await database;
    final result = await db.query(
      'CachedUser',
      orderBy: 'rowid DESC',
      limit: limit,
    );
    return result.map((e) => UserModel.fromJson(e)).toList();
  }
}
