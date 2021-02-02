import 'package:flutter/material.dart';
import 'package:todo_app/Model/Todo.dart';

class Task {
  Task({this.taskId, @required this.taskName , this.colorId});

  int taskId;
  List<Todo> _todoList;
  String taskName;
  int colorId;


  List<Todo> get todoList => _todoList;

  set todoList( List<Todo> list ){
    _todoList = list;
  }

  static final String TASK_ID = "TASK_ID";
  static final String LIST_OF_TODO = "LIST_OF_TODO";
  static final String TASK_NAME = "TASK_NAME";
  static final String COLOR_ID = "COLOR_ID";

  Map<String, dynamic> toJson() => <String, dynamic>{
        TASK_ID: taskId,
        TASK_NAME: taskName,
        COLOR_ID : colorId
      };

  static Task fromJson(Map map) {
    return Task(
      taskId: map[TASK_ID],
      taskName: map[TASK_NAME],
      colorId: map[COLOR_ID],
    );
  }

  String toString(){
    return "task id : ${taskId }  , task name : ${taskName} , task Color ID  : $colorId} , list of todo : ${todoList} /n\n";
  }


}
