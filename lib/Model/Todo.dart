import 'package:flutter/cupertino.dart';

class Todo{

  Todo( { this.taskId , this.todoId ,  @required this.name , @required this.isDone } );

  int todoId;
  int taskId;
  String name;
  bool isDone;


  static final String TASK_ID = "taskId";
  static final String TODO_ID = "todoId";
  static final String NAME = "name";
  static final String IS_DONE = "isDone";


  Map<String , dynamic> toJson() => <String , dynamic>{
    TASK_ID : taskId ,
    TODO_ID : todoId ,
    NAME : name ,
    IS_DONE : isDone == true ? 1 : 0
  };

    static Todo fromJson( Map<String, dynamic> map ){
      return Todo(
        taskId: map[ TASK_ID ],
        todoId: map [ TODO_ID ],
        name: map [ NAME ],
        isDone:  map[ IS_DONE ] == 1
      );
    }


    String toString(){
      return "id = $todoId , taskId = $taskId , name = $name , isDone = $isDone ";
    }

}