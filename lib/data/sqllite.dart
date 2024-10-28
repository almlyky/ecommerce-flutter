import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class dbase{
  static Database? _db;
  Future<Database?> get db async{
    if(_db==null){
      _db=await initialdb();
      print("........................ created database ecommerce_app .....................................");
      return _db;
    }
    else {
      return _db;
    }
  }
  initialdb() async {
    try {
      String dbpath = await getDatabasesPath();
      String path = join(dbpath, 'ecommerce2.db');
      Database mydb = await openDatabase(path, onCreate: _oncreate, version: 2);
      return mydb;
    }
    catch(e){
      print("error in database :  $e");
    }
  }
  _oncreate(Database db,int version) async{
    // Batch batch=db.batch();
    // await db.execute(
    //     '''
    //   create table "cart"(
    //   "cart_no" integer not null primary key autoincrement,
    //   "car" text not null,
    //   "dept_loc" text not null,
    //   "dept_image" text not null
    //   );
    //   '''
    // );
    // print("........................ created dept .....................................");
    //
    // await db.execute('''
    //
    //     create table "product"(
    //     "product_no" integer not null primary key autoincrement,
    //     "product_disc" text,
    //     "product_name" text not null,
    //     "product_image" text not null,
    //     "product_price" integer not null,
    //     "dept_foreign" int not null,
    //      foreign key(dept_foreign) references dept(dept_no)
    //     );
    //     '''
    // );
    // print("........................ created product .....................................");

    await db.execute('''
        create table "favorite"(
        "fav_no" integer not null primary key autoincrement,
        "pr_no" integer not null,
        "pr_name" text not null,
        "pr_image" text not null,
        "pr_price" integer not null,
        "pr_detail" text not null
       );
    ''');
    print("........................ created favorite .....................................");

    await db.execute('''
        create table "cart"(
        "cart_no" integer not null primary key autoincrement,
        "cat_fk" integer not null,
        "pr_name" text not null,
        "pr_image" text not null,
        "pr_price" integer not null,
        "cart_quantity" integer not null
        );
    ''');
    print("........................ created cart .....................................");

  }readdata(String sql) async{
    Database? mydb=await db;
    var response=await mydb!.rawQuery(sql);
    return response;
  }
  insertdata(String sql) async{
    Database? mydb=await db;
    int response=await mydb!.rawInsert(sql);
    return response;
  }
  updatedata(String sql) async{
    Database? mydb=await db;
    int response=await mydb!.rawUpdate(sql);
    return response;
  }
  deletedata(String sql) async{
    Database? mydb=await db;
    int response=await mydb!.rawDelete(sql);
    return response;
  }
  deletesdatabases()async{
    String dbpath = await getDatabasesPath();
    String path =join(dbpath,'abubaker.db');
    await deleteDatabase(path);
    print("delleted");

  }
}