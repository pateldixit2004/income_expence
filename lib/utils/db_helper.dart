import 'dart:io';

import 'package:income_expence/screen/model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBhelper {
  static DBhelper dBhelper = DBhelper();
  Database? database;
  final String Dbpath = "database.db";
  String datatable = 'datatable';
  String amount = 'amount';
  String note = "note";

  Future<Database?> checkDb() async {
    if (database != null) {
      return database;
    } else {
      return await intDb();
    }
  }

  Future<Database> intDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, Dbpath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        return await db.execute(
            'CREATE TABLE $datatable(id INTEGER PRIMARY KEY AutoIncrement  ,$amount INTEGER ,$note TEXT,img BLOB)');
      },
    );
  }

  Future<void> insertdb({IncomeModel? model}) async {
    // database=await  instance.da
    database = await checkDb();
    await database!
        .insert('$datatable', {"note": model!.note, "amount": model.amount,"img":model.imgUnit});
  }

  Future<List<Map>> readDb() async {
    database = await checkDb();
    String quary = "SELECT * FROM $datatable";
    List<Map> l1 = await database!.rawQuery(quary);
    return l1;
  }

  Future<void> delete(int id) async {
    database = await checkDb();
    database!.delete(datatable, where: "id =?", whereArgs: [id]);
  }

  Future<void> update(IncomeModel model) async {
    database = await checkDb();
    database!.update(datatable, {"amount": model.amount, "note": model.note,"img":model.imgUnit},
        where: "id=?", whereArgs: [model.id]);
  }
}
