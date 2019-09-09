import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import './video_model.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), "VideoDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE videos(id INTEGER PRIMARY KEY, name TEXT, url TEXT, downloadUrl TEXT, thumbnailPath TEXT, filePath TEXT)",
      );
    });
  }

  
newClient(Video newVideo) async {
    final db = await database;
    var res = await db.insert("Client", newVideo.toMap());
    return res;
  }
}
