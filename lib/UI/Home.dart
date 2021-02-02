import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Model/Task.dart';
import 'package:todo_app/Presenter/HomePresenter.dart';
import 'package:todo_app/Settings/Themes.dart';
import 'package:todo_app/Settings/settings.dart';
import 'package:todo_app/UI/Appbar.dart';
import 'package:todo_app/UI/Dialouge.dart';
import 'package:todo_app/UI/Task.dart';
import 'package:todo_app/UI/TaskDetails.dart';
import 'package:todo_app/create_task.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  Appbar _appBar;
  bool loading = true;
  List<Task> taskList;
  List<Widget> children;
  HomePresenter _presenter;

  Color currentColor = Colors.blue;

  void showLoadingScreen() {
    setState(
      () {
        loading = true;
      },
    );
  }

  void hideLoadingScreen() {
    setState(
      () {
        loading = false;
      },
    );
  }

  loadTasks() {
    _presenter.loadHomeScreenData();
  }

  updateHomeScreenTasks(List<Task> newList) {

    setState(
      () {
        taskList = newList;
        prepareChildren();
        hideLoadingScreen();
      },
    );
    setState(
      () {
        children;
      },
    );
  }

  bool dismiss = false;

  void prepareChildren() {
    children = [
      SizedBox(
        height: 100,
      ),
      Expanded(
        child: taskList.isEmpty ? Center( child: Text("There is no Tasks"),) : ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: taskList.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              onDismissed:(dir){
                _presenter.deleteTask( taskList[index] );
              },
              confirmDismiss: ( dir )async{
                await onDeleteDmismiss( taskList[index] );
                return dismiss;
              },
              key: UniqueKey(),
              direction: DismissDirection.vertical,
              child: GestureDetector(
                onTap: () async {},
                child: TaskUI(
                  MediaQuery.of(context).size.width / 2,
                  MediaQuery.of(context).size.width /
                      3, // -  ( MediaQuery.of(context).size.height / 3 )
                  taskList[index],
                  () {
                    onPressed(taskList[index]);
                  },
                ),
              ),
            );
          },
        ),
      ),
      SizedBox(
        height: 100,
      ),
    ];
  }

  onPressed(Task task) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return TaskDetails(task);
    }));
    _presenter.loadHomeScreenData();
  }

  void menuItemListener(String event) {}

  HomeState() {
    _appBar = Appbar.withMenuItems(menuItemListener);
    _presenter = HomePresenter(this);
    _presenter.init().then(
      (value) {
        loadTasks();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          createTask(context, onCreateTask);
        },
      ),
      appBar: AppBar( centerTitle: true, title: Text("Tasks App"), ),  //_appBar.getAppbar(),
      body: Center(
          child: loading
              ? CircularProgressIndicator()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: children,
                )),
    );
  }

  onCreateTask(String name) {
    _presenter.createTask(name, currentColor.value);
  }

  final _formKey = GlobalKey<FormState>();

  createTask(BuildContext context, dynamic onSubmittion) async {
    TextEditingController textEditingController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("CRATE NEW TASK"),
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height -
                (MediaQuery.of(context).size.height / 4)),
            child: Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text("Enter task name"),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "PLEASE ENTER TASK NAME";
                          }
                          return null;
                        },
                        controller: textEditingController,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: BlockPicker(
                      pickerColor: currentColor,
                      onColorChanged: (value) {
                        currentColor = value;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
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
                if (_formKey.currentState.validate()) {
                  onSubmittion(textEditingController.text);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }





  onDeleteDmismiss( Task task ) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
      return AlertDialog(
        title: Text("DELETE"),
        content: Text("ARE YOU SURE YOU WANT TO DELETE ${ task.taskName } ?"),
        actions: [
          RaisedButton(
            child: Text("OK"),
            onPressed: () async {
              dismiss = true;
              Navigator.pop(context);
            },
          ),
          RaisedButton(
            child: Text("CANCEL"),
            onPressed: () {
              dismiss = false;
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
    );
  }



}
