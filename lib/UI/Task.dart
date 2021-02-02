import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Model/Task.dart';
import 'package:todo_app/Model/Todo.dart';
import 'package:todo_app/UI/TaskDetails.dart';

class TaskUI extends StatelessWidget {
  double width;
  double height;
  Task _task;
  dynamic onPressed;

  TaskUI(this.width, this.height, this._task , this.onPressed );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
/*        await Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return TaskDetails(_task);
        }));
     */

      onPressed();
      },
      child: Container(
        width: width,
        height: height ,
        color: Color(  _task.colorId ) ,
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(8),
              child: Center(
                child: Text(
                  "${_task.taskName}",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            Divider(
              height: 20,
              color: Colors.white,
            ),
            _task.todoList == null ?
            Text(
                    "There is no TODO",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                : _task.todoList.isEmpty
                    ? Text(
                        "There is no TODO",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    : Expanded(
                        child: Container(
                            margin: EdgeInsets.all(8),
                            child: ListView(
                              children: prepareWidgets(),
                            )))
          ],
        ),
      ),
    );
  }

  List<Widget> prepareWidgets() {
    List<Widget> myList = List<Widget>();
    if (_task.todoList != null)
      _task.todoList.forEach((Todo todo) {
        myList.add(
          packWidget(todo),
        );
      });
    print(myList);
    return myList;
  }

  Widget packWidget(Todo todo) {
    return ListTile(
      leading: Checkbox(
        value: todo.isDone,
        onChanged: (newValue) {
          todo.isDone = newValue;
          return newValue;
        },
      ),
      title: Container(
        margin: EdgeInsets.only(top: 8, bottom: 8),
        child: Text(
          "${todo.name}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            decoration: todo.isDone ?   TextDecoration.lineThrough : TextDecoration.none ,
          ),
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }
}
