
import 'package:flutter/material.dart';
import 'package:path/path.dart';//-1

import 'package:sqflite/sqflite.dart'; //-5
// Create,Read,Update,Delete
//-2 terminalden flutter pub add sqflite sqflite_common_ffi yazıyoruz


// //Android Emulatörle bağlantı kurulması için;
class MyDb{//-3
  Database? db;//-4
  Future open() async { //-6
    var databasePath = await getDatabasesPath();//-7
    String path = join(databasePath,"plant.db"); //-8
    print(path);//-9
    db = await openDatabase(path,version: 1,//-10
    onCreate: (Database db,int version) async {
      await db.execute( //-11
          '''
          CREATE TABLE plants(
          id integer primary key,
          plant varchar(255) not null,
          image varchar(255) not null,
          price double not null);
      '''
      );
    });

  }
}