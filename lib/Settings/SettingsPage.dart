

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Settings/Themes.dart';
import 'package:todo_app/Settings/settings.dart';

class SettingsPage extends StatelessWidget {


  int themeChoosed ;
  BuildContext buildContext;
  @override
  Widget build(BuildContext context) {

    themeChoosed = Provider.of<Settings>(context).getThemeNumber;
    buildContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("SETTINGS"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            SwitchListTile(
              value: Provider.of<Settings>(context).showHiddenFiles,
              title: Text("Show hidden files"),
              onChanged: (value) {
                Provider.of<Settings>(context).showHiddenFiles = value;
              },
            ),
            SwitchListTile(
              value: Provider.of<Settings>(context).showAsGrid,
              title: Text("show files as Grid "),
              onChanged: (value) {
                Provider.of<Settings>(context).showAsGrid = value;
                return value;
              },
            ),
            ListTile(
              title: Text("select Theme"),
              subtitle: Container(
                padding: EdgeInsets.all( 8 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    circle(
                        number: 0,
                        circleColor: Themes.blueTheme.primaryColor ,
                        borderColor: Colors.green ),
                    circle(
                        number: 1,
                        circleColor: Themes.redTheme.primaryColor ,
                        borderColor: Colors.green ),
                    circle(
                        number: 2,
                        circleColor: Themes.yellowTheme.primaryColor,
                        borderColor: Colors.green ),
                  ],
                ),
              ),
              onTap: (){},
            ),


          ],
        ),
      ),
    );
  }



  void onChange(int number) {
    Provider.of<Settings>( buildContext ).setTheme = number ;
  }

  Widget circle({int number, Color circleColor, Color borderColor}) {
    return GestureDetector(
      onTap: () {
        onChange(number);
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: new BoxDecoration(
            color: circleColor,
            shape: BoxShape.circle,

            border: themeChoosed == number
                ? Border.all(width: 4, color: borderColor)
                : null ,
        )
      ),
    );
  }
}
