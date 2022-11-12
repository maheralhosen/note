import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class SqlDp {

  static Database? _db ;

  Future<Database?> get db async {
    if(_db == null){
      _db = await initialDp() ;
      return _db ;
    }else {
      return _db ;
    }
  }

  initialDp() async {
    String databasepath = await getDatabasesPath() ;
    String path = join(databasepath , "maher.db") ;
    Database mydb = await openDatabase(path , onCreate: _onCreate , version: 1 , onUpgrade: _onUpgrade ) ;
    return mydb ;
  }

  _onUpgrade(Database db , int oldversion ,int newversion)async {
    print("on upgrade ========================");
    await db.execute("ALTER TABLE notes ADD COLUMN color TEXT") ;
  }
  _onCreate(Database db , int version ) async {

    Batch batch = db.batch() ;

     batch.execute('''
    CREATE TABLE "notes" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
    "title" TEXT NOT NULL ,
    "note" TEXT NOT NULL ,
    "color" TEXT NOT NULL 
    
    )
    ''');
    // batch.execute('''
    // CREATE TABLE "students" (
    // "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    // "title" TEXT NOT NULL ,
    // "note" TEXT NOT NULL
    // )
    // ''');

   await batch.commit() ;

    print("on create =========================") ;
  }

  // readData(String sql) async {
  //   Database? mydb = await db ;
  //   List<Map> response = await mydb!.rawQuery(sql) ;
  //   return response ;
  // }
  // insertData(String sql) async {
  //   Database? mydb = await db ;
  //   int response = await mydb!.rawInsert(sql) ;
  //   return response ;
  // }
  // updateData(String sql) async {
  //   Database? mydb = await db ;
  //   int response = await mydb!.rawUpdate(sql) ;
  //   return response ;
  // }
  // deleteData(String sql) async {
  //   Database? mydb = await db ;
  //   int response = await mydb!.rawDelete(sql) ;
  //   return response ;
  // }
  // mydeletedatabase () async{
  //   String databasepath = await getDatabasesPath() ;
  //   String path = join(databasepath , "maher.db") ;
  //    await deleteDatabase(path) ;
  //
  // }
  read(String table) async {
    Database? mydb = await db ;
    List<Map> response = await mydb!.query(table) ;
    return response ;
  }
  insert(String table , Map<String , Object?> values ) async {
    Database? mydb = await db ;
    int response = await mydb!.insert(table,values ) ;
    return response ;
  }
  update(String table , Map<String , Object?> values , String? mywhere ) async {
    Database? mydb = await db ;
    int response = await mydb!.update(table , values , where: mywhere) ;
    return response ;
  }
  delete(String table ,String? mywhere) async {
    Database? mydb = await db ;
    int response = await mydb!.delete(table ,where: mywhere ) ;
    return response ;
  }

}