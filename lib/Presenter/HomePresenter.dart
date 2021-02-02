
import 'package:todo_app/DB/DataProvider.dart';
import 'package:todo_app/Model/Task.dart';
import 'package:todo_app/UI/Home.dart';

class HomePresenter{

  HomeState _view;
  DataProvider _dataProvider;

  HomePresenter( this._view ){

  }

  Future init() async {
    _dataProvider = DataProvider();
    await _dataProvider.init();
  }

  loadHomeScreenData() async {
    List<Task> taskList = await _dataProvider.getAllTasks();
    //print("this is list of tasks : $taskList");
    _view.updateHomeScreenTasks( taskList );
    _view.hideLoadingScreen();
  }

  createTask(String name , int colorId ) async {
    _view.showLoadingScreen();
    await _dataProvider.insertTask(
      Task(
        taskName: name ,
        colorId: colorId
      )
    );
    loadHomeScreenData();

  }

  Future<void> deleteTask(Task task) async {
    await _dataProvider.deleteTask(task);
    _view.loadTasks();
  }

}