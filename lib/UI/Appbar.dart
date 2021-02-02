import 'package:flutter/material.dart';
import 'package:todo_app/UI/menu_items.dart';

class Appbar {
  MenuItems _menuItems;
  dynamic _MenuItemsListener;
  AppBar _appBar;

  Appbar.withMenuItems(this._MenuItemsListener) {}

  AppBar getAppbar() {
    _appBar = AppBar(
      actions: [
        Flexible(
          child: MenuItems(
            handleClick: _MenuItemsListener,
          ),
        )
      ],
    );

    return _appBar;
  }
}
