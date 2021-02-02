import 'package:todo_app/DB/DataProvider.dart';
import 'package:todo_app/Model/Task.dart';
import 'package:todo_app/Model/Todo.dart';
import 'package:todo_app/UI/TaskDetails.dart';

class TaskDetailsPresenter {
  TaskDetailsState _view;

  TaskDetailsPresenter(this._view) {}

  DataProvider _dataProvider;

  init() async {
    _dataProvider = DataProvider();
    await _dataProvider.init();
  }

  addTodo(Task task, String name) async {
    _view.showLoadingScreen();
    Todo todo = Todo(taskId: task.taskId, name: name, isDone: false);
    todo = await _dataProvider.insertTodo(todo);
    print("todo inserted :: $todo");
    List<Todo> todoList = await _dataProvider.getAllTodo(task.taskId);
    print(" list is :: $todoList");
    task.todoList = todoList;
    _view.update(task);
  }

  Future<void> updateTodo(Todo todo) async {
    print("update todo is called");
    _view.showLoadingScreen();
    int result = await _dataProvider.updateTodo(todo);
    if (result >= 1) {
      Task task = await _dataProvider.getTask( todo.taskId );
      List<Todo> todoList = await _dataProvider.getAllTodo(task.taskId);
      task.todoList = todoList;
      _view.update(task);
    } else {
      _view.showColudNotUpdateMessage();
    }
  }

  Future<void> deleteTask(Task task) async {
    await _dataProvider.deleteTask(task);
    _view.closeTask();
  }

  Future deleteTodoList( List<Todo> list ) async {

     await _dataProvider.deleteListOfTodo( list );

  }
}
