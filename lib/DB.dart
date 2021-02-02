
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/todo.dart';

class DB {
  DB() {
    init();
  }

  static final String _id = "id";
  static final String _title = "title";
  static final String _desc = "description";
  static final String _isDone = "isDone";
  static final String _date = "date";
  static final String _addedDate = "addedDate";

  static String _tableName = "TODO";
  static String _DBName = "TODO.db";
  String createDbTable =
      "CREATE TABLE $_tableName( $_id INTEGER PRIMARY KEY, $_title TEXT, $_desc TEXT ,  $_isDone INTEGER , $_date VARCHAR  , $_addedDate VARCHAR )";
  static final String _queryByTitle =
      "SELECT * FROM $_tableName ORDER BY $_title ";

  Database database;

  void init() async {
    database = await openDatabase(
      join(await getDatabasesPath(), '$_DBName'),
      onCreate: (db, version) => db.execute(
        createDbTable,
      ),
      version: 1,
    );


  }

  Future<void> insert(Todo todo) async {
    await init();
    Map<String, dynamic> todoMapped = {
      "$_id": todo.id,
      "$_title": todo.title,
      "$_desc": todo.description,
      "$_isDone" : 0 ,
    };

    print(todoMapped);
    if (database == null) {
      print("the db is null");
    } else {
      int id = await database.insert( _tableName, todoMapped ,  conflictAlgorithm : ConflictAlgorithm.replace );
      print("the is of the given to inserted is :  $id");
    }

    database.close();
  }

  Future<List<Todo>> todos() async {
    await init();

    final List<Map<String, dynamic>> maps = await database.query(_tableName);

    database.close();

    return convertToTodo(maps);
  }

  Future<List<Todo>> todosByTitle() async {
    await init();
    final List<Map<String, dynamic>> maps =
        await database.rawQuery(_queryByTitle);
    database.close();
    return convertToTodo(maps);
  }

  Future<List<Todo>> searchTodosByTitle(String title) async {

    await init();

    final List<Map<String, dynamic>> maps = await database.query(
      _tableName,
      columns: [_id, _title, _desc, _isDone,_date, _addedDate],
      where: "$_title like ?" ,
      whereArgs: [ '%$title%' ]
    );

    //final List<Map<String, dynamic>> maps = await database.rawQuery(query, [title]);
    database.close();
    print("inside search BY title :: map :: ");
    print( maps );
    return convertToTodo(maps);
  }

  Future<dynamic> deleteById(int id) async {
    await init();
    var count =
       await database.delete( _tableName, where: '$_id = ? ', whereArgs: ['$id'] );
    print("deleted rows is :  $count");
    database.close();
    return count;
  }

  Future deleteAll() async {
    await init();
    var count = await database.delete(_tableName);
    print("deleted rows is :  $count");
    database.close();
    return count;
  }

  Future deleteByTitle(String title) async {
    await init();
    var count = await database
        .delete(_tableName, where: '$_title = ? ', whereArgs: [title]);
    print("deleted rows is :  $count");
    database.close();
    return count;
  }


  Future updateTodo( Todo todo ) async {
    await init();

    int count = await database.rawUpdate("update $_tableName SET title = ? , $_desc =  ? , $_isDone = ? ,  $_date=? , $_addedDate = ? where $_id = ?",
        [
          '${todo.title}' , '${todo.description }' , todo.isDone==true?1:0 , '${todo.date }' , '${todo.addedDate}' , '${todo.id}' ,
        ]);
    print("updated rows is :  $count");
    database.close();
    return count;

  }


  List<Todo> convertToTodo(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {

      Todo todo =  Todo(
        id: maps[i]['$_id'],
        title: maps[i]['$_title'],
        description: maps[i]['$_desc'],
        isDone: maps[i]['$_isDone']== 0  ? false : true  ,
      );

      print( todo.toString() );
      return todo;
    });
  }

  void closeDatabase() {
    database.close();
  }
}
