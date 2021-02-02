import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Model/Task.dart';
import 'package:todo_app/Model/Todo.dart';
import 'package:path/path.dart';

class TaskDB {
  Database db;

  static final String taskTable = "task_table";
  static final String _DBName = "TODO_DB";

  Future open() async {
    print("i am inside task table");
    db = await openDatabase(join(await getDatabasesPath(), '$_DBName'),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
create table $taskTable ( 
  ${Task.TASK_ID} integer primary key autoincrement, 
  ${Task.TASK_NAME} text not null,
  ${Task.COLOR_ID} integer ,
''');
    });
  }

  Future<Task> insert(Task task) async {
    task.taskId = await db.insert(taskTable, task.toJson());
    return task;
  }

  Future<Task> getTaskByID(int id) async {
    List<Map> maps = await db.query(taskTable,
        columns: [Task.TASK_ID, Task.TASK_NAME, Task.COLOR_ID],
        where: '${Task.TASK_ID} = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Task.fromJson(maps.first);
    }
    return null;
  }

  Future<List<Task>> getTaskList() async {
    List<Map> maps = await db.query(
      taskTable,
      columns: [ Task.TASK_ID, Task.TASK_NAME, Task.COLOR_ID ],
    );
    List<Task> taskList = List<Task>();
    maps.forEach((Map map) {
      Task task = Task.fromJson(map);
      taskList.add(task);
    });
    return taskList;
  }



  Future<int> delete(int id) async {
    return await db
        .delete(taskTable, where: '${Task.TASK_ID} = ?', whereArgs: [id]);
  }

  Future<int> update(Task task) async {
    return await db.update(taskTable, task.toJson(),
        where: '${Task.TASK_ID} = ?', whereArgs: [task.taskId]);
  }

  Future close() async => db.close();
}
