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
    String path = join(await getDatabasesPath(), "CoonTubeDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
      print(db);
      print("succes");
    },
        onCreate: (Database db, int version) async {
        print("create database lol");
      await db.execute(
        "CREATE TABLE Video("
        "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL," 
        "name TEXT," 
        "url TEXT," 
        "downloadUrl TEXT," 
        "thumbnailPath TEXT," 
        "filePath TEXT," 
        "formatSelected TEXT"
        ")");
    });
  }

  
newVideo(Video newVideo) async {
    final db = await database;
    print(videoToJson(newVideo));
    print(db);
    var res = await db.insert("Video", newVideo.toMap());
    print(res);
    return res;
    /* var res=await db.query("Video");
    print(res);
    return res; */
  }
}
