import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks_to_do/models/task_model.dart';

class TodoDatabase {
  Database _db;
  final String _itemsTable = "itemstable";
  final String _id = "id";
  final String _title = "title";
  final String _isDone = "isdone";
  final String _taskTime = "tasktime";

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "Todo.dp");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $_itemsTable($_id INTEGER PRIMARY KEY , $_title TEXT ,$_isDone INTEGER ,$_taskTime TEXT)");
  }

  Future<int> saveItem(Task item) async {
    var dbClient = await db;
    int res = await dbClient.insert("$_itemsTable", item.toMap());
    return res;
  }

  Future<List> getAllItem() async {
    var dbClient = await db;
    List allItems = await dbClient.query("$_itemsTable");
    return allItems;
  }

  Future<Task> getItem(int id) async {
    var dbClient = await db;
    var res =
        await dbClient.rawQuery("SELECT * FROM $_itemsTable WHERE id = $id");
    if (res.length > 0) {
      return Task.fromMap(res.first);
    }
    return null;
  }

  Future<int> deleteItem(int id) async {
    var dbClient = await db;
    int res =
        await dbClient.delete("$_itemsTable", where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future<int> updateItem(int id, Task item) async {
    var dbClient = await db;
    int res = await dbClient
        .update("$_itemsTable", item.toMap(), where: "id = ?", whereArgs: [id]);
    return res;
  }
}
