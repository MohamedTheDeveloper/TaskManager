
import 'package:todo_app/DB/task_db.dart';
import 'package:todo_app/DB/todo_db.dart';
import 'package:todo_app/Model/Task.dart';
import 'package:todo_app/Model/Todo.dart';

class DataProvider{

  TaskDB _taskDB;
  TodoDB _todoDB;

  init() async {
    _todoDB = TodoDB();
    await _todoDB.open();
    _taskDB  = TaskDB();
    await _taskDB.open();
  }

  Future<int> updateTodo( Todo todo ) async {
    return await _todoDB.update(todo);
  }

  Future<int> deleteTodo( Todo todo ) async {
    return await _todoDB.delete( todo.todoId );
  }

  Future<Todo> insertTodo( Todo todo )async{
    return await _todoDB.insert( todo );
  }


  Future<Task> insertTask( Task task ) async{
    return await _taskDB.insert( task );
  }

  Future<List<Todo>> getAllTodo( int taskID ) async {
    return await _todoDB.getTodoList( taskID );
  }

  Future<List<Task>> getAllTasks() async {
    List<Task> taskList = await _taskDB.getTaskList();
    for( int i = 0 ; i < taskList.length; i++ ){
      List<Todo> list = await _todoDB.getTodoList( taskList[i].taskId );
      taskList[i].todoList = list;
    }
/*    taskList.forEach(( Task task ) async {
      List<Todo> list = await _todoDB.getTodoList( task.taskId );
      print("list of tasks :: $list");
      task.todoList = list;
    });*/
    print("all task list :: $taskList");
    return taskList;
  }

  Future<int> updateTask( Task task ) async {
    return await _taskDB.update( task );
  }

  Future<int> deleteTask( Task task ) async{
    return await _taskDB.delete( task.taskId );
  }

  Future<Task> getTask(int taskId) async {
    return await _taskDB.getTaskByID( taskId );
  }

  Future deleteListOfTodo( List<Todo> todoList) async {
    return await _todoDB.deleteList( todoList );
  }








}