
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Model/Task.dart';
import 'package:todo_app/Model/Todo.dart';
import 'package:path/path.dart';
class TodoDB {

  Database db;

  static final String taskTable = "task_table";
  static final String todoTable = "todo_table";
  static final String _DBName = "TODO_DB";

  Future open() async {
    db = await openDatabase( join(await getDatabasesPath(), '$_DBName') , version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
create table $todoTable ( 
  ${ Todo.TODO_ID } integer primary key autoincrement, 
  ${ Todo.TASK_ID } integer ,
  ${Todo.NAME } text not null,
  ${ Todo.IS_DONE } integer not null)
''');
          await db.execute('''
create table $taskTable ( 
  ${Task.TASK_ID} integer primary key autoincrement, 
  ${Task.TASK_NAME} text not null,
  ${Task.COLOR_ID} integer )
''');
        });
  }


  Future<Todo> insert(Todo todo) async {
    todo.todoId = await db.insert( todoTable , todo.toJson() );
    return todo;
  }

  Future<Todo> getTodoByID(int id) async {
    List<Map> maps = await db.query( todoTable,
        columns: [ Todo.TODO_ID , Todo.TASK_ID , Todo.NAME , Todo.IS_DONE ],
        where: '${ Todo.TODO_ID } = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Todo.fromJson( maps.first );
    }
    return null;
  }


  Future<List<Todo>> getTodoList(int taskId) async {
    List<Map> maps = await db.query( todoTable,
        columns: [ Todo.TODO_ID , Todo.TASK_ID , Todo.NAME , Todo.IS_DONE ],
        where: '${ Todo.TASK_ID } = ?',
        whereArgs: [ taskId ]);
    List<Todo> todoList = List<Todo>();
    maps.forEach(( Map map ) {
      Todo todo = Todo.fromJson( map );
      todoList.add( todo );
    });
    return todoList;

  }



  Future insertList(List<Todo> todoList) async {
    Batch batch = db.batch();
    todoList.forEach(( Todo todo ) async {
      await batch.insert( todoTable , todo.toJson() );
    });
    var result = await batch.commit();
    return result;
  }




  Future deleteList(List<Todo> todoList) async {
    Batch batch = db.batch();
    todoList.forEach(( Todo todo ) async {
      await batch.delete( todoTable , where: '${Todo.TODO_ID } = ?', whereArgs: [ todo.todoId ]);
    });
    var result = await batch.commit();
    return result;
  }




  Future<int> delete(int id) async {
    return await db.delete( todoTable , where: '${Todo.TODO_ID } = ?', whereArgs: [id]);
  }

  Future<int> update(Todo todo) async {
    return await db.update( todoTable , todo.toJson(),
        where: '${ Todo.TODO_ID } = ?', whereArgs: [ todo.todoId ]);
  }

  Future close() async => db.close();



}