import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  /// Holds the common code used in [insert] & [getData]
  /// Code to get access to our Database, that is why it returns the Database
  static Future<sql.Database> dataBase() async {
    /// Know we know where to store out DB, its just the folder where we are going to store
    final dbPath = await sql.getDatabasesPath();

    /// Eiether it will open an existing DB with the path we are passing here, else it will create a new one file places.db
    ///
    /// onCreate: will be executed if openDatabase tries to create the file if it coudnt find it, then you can Initialize you DB when its created for the first time
    /// It returns dataBase & version. version is not clear to me but you dont need to change version if you
    ///
    /// 💙 OpenDatabase: returns a future which yields a handle to the DB, so now return your db here
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      // We have to return it as it returns the future it will automatically we returned but to digest sql we add return 😂 return is redundant
      // Also we want to store path to the image on our device that is why image is TEXT
      /// ! user_places is our table name while places.db is our dataBase name
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
  }

  static Future<void> insert(
      String tableName, Map<String, dynamic> data) async {
    /// ⭐ conflictAlgorithm just ensures that what you want to do if data is conflicted or have same id, i just want to replace old with new -> Shouldn't happend though
    final db = await DBHelper
        .dataBase(); // coz dataBase() return us a Future Database so we need await it
    db.insert(tableName, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  /// Returns a list of tables also table is in map format as same way we added them to know more hover over query to see its return value
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.dataBase();
    // Query is used to fetch the data form table
    return db.query(table);
  }
}
