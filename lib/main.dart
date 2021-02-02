

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:todo_app/DB/DataProvider.dart';
import 'package:todo_app/DB/todo_db.dart';
import 'package:todo_app/Model/Task.dart';
import 'package:todo_app/Settings/settings.dart';
import 'package:todo_app/UI/Home.dart';

import 'Model/Todo.dart';

void main() {

  runApp( MyApp() );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
      home: SplashScreenApp(),
    );
  }
}





class SplashScreenApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }

}

class _MyAppState extends State<SplashScreenApp> {

  Settings settings = Settings();


  @override
  Widget build(BuildContext context) {



    return new SplashScreen(

        navigateAfterFuture: navFuture(),
/*        seconds: 5,
        navigateAfterSeconds: ChangeNotifierProvider(
            builder: (context) {
              return settings;
            },
            child: test()
        ),*/
        //navigateAfterFuture: navFuture() ,
        title: new Text('Welcome to Task Manager',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: (){},
        loaderColor: Colors.red
    );
  }

  Future navFuture() async {

    DateTime dateTime = DateTime.now();

    DataProvider dataProvider = DataProvider();
    await dataProvider.init();
    await  settings.init();

    DateTime dateTime2 = DateTime.now();

    var duration = dateTime2.microsecond - dateTime.microsecond;
    int waitingTime = 2000;
    if( duration < waitingTime ){
      await Future.delayed( Duration(
        milliseconds: waitingTime - duration
      ));
    }

    return ChangeNotifierProvider(
        builder: (context) {
          return settings;
        },
        child: Home()
    );


  }
}

