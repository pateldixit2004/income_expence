import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBhelper
{
  static DBhelper dBhelper=DBhelper();
  Database? database;
  final String Dbpath="database.db";

  Future<Database?> createDb()
  async {
    if(database!=null)
      {
        return database;
      }
    else
      {
        return await intDb();
      }
  }

  Future<Database> intDb()
  async {
    Directory dir=await getApplicationDocumentsDirectory();
    String path=join(dir.path, Dbpath);

    return await openDatabase(path,version: 1,onCreate: (db, version) async {
      return await db.execute('CREATE TABLE datatable(id INTEGER PRIMARY KEY AUTOINCREMATE ,amount INTEGER ,note TEXT)');
    },);
  }

  Future<int> insertdb({note,amount})
  async {
    // database=await  instance.da
    database=await createDb();
        return await  database!.insert('datatable', {"note":note,"amount":amount});
  }
}