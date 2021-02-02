import 'package:flutter/material.dart';

class Themes {

  static final ThemeData blueTheme = ThemeData(
      primaryColor: Colors.blue ,
      brightness: Brightness.light,
      accentColor: Colors.blueAccent ,
      unselectedWidgetColor: Colors.black ,
      iconTheme: IconThemeData(
        color: Colors.white ,

      ),
      textTheme: TextTheme(
          display1: TextStyle(
              color: Colors.black ,
              fontSize:  16 ,
          ),
        subtitle: TextStyle(
          color: Colors.white ,
          fontSize:  16
        ),
        display2: TextStyle(
            color: Colors.white ,
            fontSize:  16
        ) ,

      )
  );

  static final ThemeData redTheme = ThemeData(
      primaryColor: Colors.red  ,
      brightness: Brightness.light ,
      accentColor: Colors.redAccent ,
      unselectedWidgetColor: Colors.black ,
      iconTheme: IconThemeData(
        color: Colors.white ,

      ),
      textTheme: TextTheme(
        display1: TextStyle(
          color: Colors.black ,
          fontSize:  16 ,
        ),
        subtitle: TextStyle(
            color: Colors.white ,
            fontSize:  16
        ),
        display2: TextStyle(
            color: Colors.white ,
            fontSize:  16
        ) ,

      )
  );

  static final ThemeData yellowTheme = ThemeData(
      primaryColor: Colors.amber ,
      brightness: Brightness.light,

      accentColor: Colors.amberAccent   ,
      iconTheme: IconThemeData(
        color: Colors.white ,

      ),
      textTheme: TextTheme(
          display1: TextStyle(
              color: Colors.black ,
              fontSize:  16
          ) ,
        display2: TextStyle(
            color: Colors.white ,
            fontSize:  16
        ) ,


      )
  );

  static int numberOfThemes = 3;



  static getTheme ( int themeNumber ){
    switch( themeNumber ){
      case 0 :
        return blueTheme;
        break;
      case 1:
        return redTheme;
        break;
      case 2 :
        return yellowTheme;
        break;
      default : return blueTheme ;
    }
  }

}