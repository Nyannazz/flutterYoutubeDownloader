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
    }, onCreate: (Database db, int version) async {
      print("create database lol");
      await db.execute("CREATE TABLE Video("
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
    var res = await db.insert("Video", newVideo.toMap());
    /* print(res); */
    return res;
  }

 /*  getVideo(int id) async {
    final db = await database;
    var res = await db.query("Video", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Video.fromMap(res.first) : Null;
  } */

  getAllVideos() async {
    final db = await database;
    var res = await db.query("Video");

    /* return res; */
    print(res);
    return res.isNotEmpty ? res.map((c) => Video.fromMap(c)).toList() : [];
  }

  /* deleteClient(int id) async {
    final db = await database;
    db.delete("Video", where: "id = ?", whereArgs: [id]);
  } */
}
