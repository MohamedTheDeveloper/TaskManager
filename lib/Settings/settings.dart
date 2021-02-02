


import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Settings/Themes.dart';
import 'package:todo_app/Settings/settings_values.dart';

enum settingsValues{
  SHOW_AS_GRID ,
  SHOW_HIDDEN_FILES ,
  THEME,
  PRIMARY_COLOR ,
  SECONDARY_COLOR ,
  SORT_TYPE ,
  SORT_BY_NAME ,

}

class Settings with ChangeNotifier {



  Settings(){


  }

  ThemeData themeData = ThemeData(
  primaryColor: Colors.red
  );

   Future<SharedPreferences> init() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }




  bool _showAsGrid = false ;


  bool get showAsGrid {

    if( prefs == null )
      return _showAsGrid;

    _showAsGrid = prefs.getBool( settingsValues.SHOW_AS_GRID.toString() );
    if( _showAsGrid == null ){
      _showAsGrid = false;
    }
    print("showAsGrid ::  $_showAsGrid ");
    return _showAsGrid;

  }


  void set showAsGrid( bool showAsList ){
    this._showAsGrid = showAsList;
    prefs.setBool( settingsValues.SHOW_AS_GRID.toString() , showAsList ).then(( bool isDone){
      notifyListeners();
    });

  }


  bool _showHiddenFiles = false;

  bool get showHiddenFiles {
    if( prefs == null )
      return _showHiddenFiles;

     _showHiddenFiles = prefs.getBool( settingsValues.SHOW_HIDDEN_FILES.toString() );
    if( _showHiddenFiles == null ){
      _showHiddenFiles = false;
    }
    print("showHiddenFiles ::  $_showHiddenFiles ");
    return _showHiddenFiles;
  }

  void set showHiddenFiles( bool showHiddenFiles ){
    prefs.setBool( settingsValues.SHOW_HIDDEN_FILES.toString() , showHiddenFiles ).then((bool isDone ){
      notifyListeners();
    });

  }




  Theme setThemeColor( Color mainColor ){

    themeData =   ThemeData(
        primaryColor: mainColor
    );
    notifyListeners();
  }

  SharedPreferences prefs;


int _themeNumber = 0;

  ThemeData get getTheme{
    if( prefs == null ){
      SharedPreferences.getInstance().then( ( SharedPreferences sharedPreferences ){
        prefs = sharedPreferences;
        return getTheme;
      } );
    }
    _themeNumber = prefs.getInt( settingsValues.THEME.toString() );
    if( _themeNumber == null )
      _themeNumber  = 0;
    ThemeData myTheme = Themes.getTheme( _themeNumber );
    return myTheme;
  }

  int get getThemeNumber{
    if( prefs == null ){
      SharedPreferences.getInstance().then( ( SharedPreferences sharedPreferences ){
        prefs = sharedPreferences;
        return getThemeNumber;
      } );
    }
    _themeNumber = prefs.getInt( settingsValues.THEME.toString() );
    if( _themeNumber == null )
     _themeNumber = 0;
   return _themeNumber;
  }

  void set setTheme( int themeNumber )  {
    if(     ( themeNumber >-1  ) && themeNumber <= Themes.numberOfThemes    )
     prefs.setInt( settingsValues.THEME.toString() , themeNumber ).then(( bool isDone ){
       themeData = Themes.getTheme(themeNumber);
      notifyListeners();
    });

  }


  String _sortType ;

  String get getSortTye {
    _sortType =  prefs.getString( SettingsValue.SORT_TYPE );
    if( _sortType == null ){
      _sortType = SettingsValue.SORT_BY_NAME ;
    }
    return _sortType;
  }

  void sortByName(){
    prefs.setString( SettingsValue.SORT_TYPE , SettingsValue.SORT_BY_NAME  );
    notifyListeners();
  }

  void sortByModified(){
    prefs.setString( SettingsValue.SORT_TYPE , SettingsValue.SORT_BY_MODIFIED  );
    notifyListeners();
  }

  void sortByAccessed(){
    prefs.setString( SettingsValue.SORT_TYPE , SettingsValue.SORT_BY_ACCESSED  );
    notifyListeners();
  }





}