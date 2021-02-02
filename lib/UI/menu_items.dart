

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Settings/settings.dart';
import 'package:todo_app/Settings/settings_values.dart';

class MENU_ITEM_VALUES {

}

class MenuItems extends StatelessWidget {

  dynamic handleClick;

  MenuItems({@required this.handleClick});

  @override
  Widget build( context) {
    // TODO: implement build
    return PopupMenuButton<String>(
      onSelected: handleClick,
      itemBuilder: ( context) {
        List<PopupMenuEntry<String>> menuItems = [

          PopupMenuItem<String>(
            enabled: true,
            value: SettingsValue.SORT_BY_NAME,
            child: ListTile(
                title: Text(
                  "SETTINGS",
                ),
                leading: Icon(Icons.settings )),
          ),


        ];
        return menuItems;
      },
    );
  }
}
