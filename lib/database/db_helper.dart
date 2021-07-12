import 'dart:io';
import 'package:flutter_application_recipe/models/tips.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_application_recipe/models/item.dart';
import 'dart:async';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();

  Future<Database> initDb() async {
    // Menentukan nama database dan lokasi yang di buat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'item.db';

    // create, read databases
    var itemDatabase = openDatabase(path, version: 4, onCreate: _createDb);

    // Mengembalikan nilai object sebagai hasil dari fungsinya
    return itemDatabase;
  }

  // buat tabel baru dengan nama menu dan category
  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tips (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        title TEXT,
        deskripsi TEXT,
        image TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE menu (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        time INTEGER,
        kalori INTEGER,
        ingridients TEXT,
        step TEXT,
        image TEXT
      )
    ''');
  }

  // select databases menu
  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.initDb();
    var mapList = await db.query('menu', orderBy: 'name');
    return mapList;
  }

  // Create databases menu
  Future<int> insert(Item object) async {
    Database db = await this.initDb();
    int count = await db.insert('menu', object.toMap());
    return count;
  }

  // update tabel menu
  Future<int> update(Item object) async {
    Database db = await this.initDb();
    int count = await db
        .update('menu', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  // delete tabel menu
  Future<int> delete(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('menu', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<Item>> getItemList() async {
    var itemMapList = await select();
    int count = itemMapList.length;
    // ignore: deprecated_member_use
    List<Item> itemList = List<Item>();
    for (var i = 0; i < count; i++) {
      itemList.add(Item.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  // select tabel tips
  Future<List<Map<String, dynamic>>> selectTips() async {
    Database db = await this.initDb();
    var mapList = await db.query('tips', orderBy: 'name');
    return mapList;
  }

  // Create tabel tips
  Future<int> insertTips(Tips object) async {
    Database db = await this.initDb();
    int count = await db.insert('tips', object.toMap());
    return count;
  }

  // update tabel Tips
  Future<int> updateTips(Tips object) async {
    Database db = await this.initDb();
    int count = await db
        .update('tips', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  // delete tabel Tips
  Future<int> deleteTips(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('tips', where: 'id=?', whereArgs: [id]);
    return count;
  }

// Databases menu
  Future<List<Tips>> getTipsList() async {
    var tipsMapList = await selectTips();
    int count = tipsMapList.length;
    // ignore: deprecated_member_use
    List<Tips> tipsList = List<Tips>();
    for (var i = 0; i < count; i++) {
      tipsList.add(Tips.fromMap(tipsMapList[i]));
    }
    return tipsList;
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}
