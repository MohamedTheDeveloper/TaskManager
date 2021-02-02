import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Model/Task.dart';
import 'package:todo_app/Model/Todo.dart';
import 'package:todo_app/Presenter/TaskDetailsPresenter.dart';
import 'package:todo_app/UI/Appbar.dart';

import 'package:todo_app/UI/Dialouge.dart';
import 'package:todo_app/UI/Task.dart';
import 'package:todo_app/UI/menu_items.dart';

class TaskDetails extends StatefulWidget {
  Task _task;

  TaskDetails(this._task);

  @override
  State<StatefulWidget> createState() {
    return TaskDetailsState(_task);
  }
}

class TaskDetailsState extends State<TaskDetails> {
  Task task;
  Appbar _appbar;
  TaskDetailsPresenter _presenter;
  List<Widget> widgets = List();
  List<Todo> selectedTodo = List();

  List<Map<int, dynamic>> selectedList;

  getSelectedList() {
    selectedList = List();
    task.todoList.forEach(
      (Todo todo) {
        Map<int, dynamic> map = {
          0: false,
          1: todo,
        };
        selectedList.add(map);
      },
    );
    return selectedList;
  }

  TaskDetailsState(this.task) {
    _appbar = Appbar.withMenuItems(menuItemListener);
    _presenter = TaskDetailsPresenter(this);
    _presenter.init();
    prepareWidgets();
    init();
  }

  List<Widget> prepareWidgets() {
    widgets = List<Widget>();
    task.todoList.forEach((Todo todo) {
      print("${todo.name} is done ?:: ${todo.isDone}");
      Widget listTile = ListTile(
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (newValue) {
            return newValue;
          },
        ),
        title: todo.isDone
            ? Text(
                "WLK",
                style: TextStyle(
                    fontSize: 24, decoration: TextDecoration.lineThrough),
              )
            : Text(
                "Ahmed",
                style: TextStyle(fontSize: 24, decoration: TextDecoration.none),
              ),
        subtitle: Text(
          "2021/1/7 ",
          style: TextStyle(color: Colors.black45),
        ),
      );

      widgets.add(listTile);
    });
    return widgets;
  }

  bool isSelecting = false;

  Widget addFloatingButton() {
    return FloatingActionButton(
      backgroundColor: Color(task.colorId),
      child: Icon(Icons.add),
      onPressed: () {
        onAddTodoButtonPressed(context, onAddTodo);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height -
        _appbar.getAppbar().preferredSize.height;
    height = height - (_appbar.getAppbar().preferredSize.height / 3);
    return Scaffold(
      floatingActionButton: addFloatingButton(),
      appBar: AppBar(
        backgroundColor: Color(task.colorId),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.white,
            onPressed: () {
              ShowDialogue(
                context: context,
                title: Text("DELETE CONFIRMATION"),
                content: Text("ARE YOU SURE YOU WANT TO DELETE ${ task.taskName } ? "),
                actions: [
                  RaisedButton(child:Text("OK"), onPressed: () async {
                    await deleteTask( task );
                    Navigator.pop(context);
                  },),
                  RaisedButton(child:Text("CANCEL"), onPressed: (){
                    Navigator.pop(context);
                  },),
                ],
              );
              // _presenter.deleteTask(task);
            },
          ),
          Flexible(
            child: MenuItems(
              handleClick: menuItemListener,
            ),
          )
        ],
      ),
      body: Center(
          child: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "My Tasks",
              style: TextStyle(
                fontSize: 32,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black12,
            ),
            Expanded(child: prepareWidgets2(task.todoList)

                /* ListView(
                children: widgets,
              ),*/
                )
          ],
        ),
      )),
    );
  }

  bool confirmDismiss = false;

  Widget prepareWidgets2(List<Todo> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onLongPress: () async {
              setState(() {
                isSelecting = !isSelecting;
              });
            },
            child: Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Color(task.colorId),
                child: Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              direction: DismissDirection.startToEnd,
              onDismissed: (DismissDirection dir) {
                deleteTodo(list[index]);
              },
              confirmDismiss: (dir) async {
                confirmDismiss = false;
                await onDeleteSwip(list[index]);
                return confirmDismiss;
              },
              // key: Key("${list[index].todoId}"),
              child: ListTile(
                leading: Checkbox(
                  value: list[index].isDone,
                  onChanged: (newValue) {
                    onCheckBoxChange(newValue, list[index]);
                  },
                ),
                title: Text(
                  list[index].name,
                  style: TextStyle(
                    fontSize: 24,
                    decoration: list[index].isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                subtitle: Text(
                  "2021/1/7 ",
                  style: TextStyle(color: Colors.black45),
                ),
              ),
            ),
          );
        });
  }

  onAddTodo(String name) {
    _presenter.addTodo(task, name);
  }

  update(Task task) {
    setState(() {
      this.task = task;
      init();
    });
  }

  void init() {
    prepareWidgets();
    getSelectedList();
  }

  onCheckBoxChange(bool value, Todo todo) {
    todo.isDone = value;
    _presenter.updateTodo(todo);
  }

  onAddTodoButtonPressed(BuildContext context, dynamic onSubmittion) async {
    TextEditingController textEditingController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Todo Name"),
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: textEditingController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "PLEASE ENTER THE NAME OF THE TODO";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                child: Text(
                  "CANCEL",
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              RaisedButton(
                child: Text(
                  "OK",
                ),
                onPressed: () {
                  if (_formKey == null) {
                    print("the form key is nulll");
                  }
                  if (_formKey.currentState.validate()) {
                    onAddTodo(textEditingController.text);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        });
  }

  onDeleteSwip(Todo todo) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("DELETE"),
          content: Text("ARE YOU SURE YOU WANT TO DELETE ${todo.name} ?"),
          actions: [
            RaisedButton(
              child: Text("OK"),
              onPressed: () async {
                confirmDismiss = true;
                Navigator.pop(context);
              },
            ),
            RaisedButton(
              child: Text("CANCEL"),
              onPressed: () {
                confirmDismiss = false;
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void showColudNotUpdateMessage() {}

  void closeTask() {
    Navigator.pop(context);
  }

  Future<void> deleteTodo(Todo todo) async {
    // await onAddTodoButtonPressed(context, () {});
    _presenter.deleteTodoList([todo]);
  }

  Future<void> deleteTask(Task task ) async {
   await  _presenter.deleteTask(task);
  }


  showLoadingScreen() {}

  dynamic menuItemListener(String event) {}
}
