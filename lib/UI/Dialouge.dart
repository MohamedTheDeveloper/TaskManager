import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowDialogue{

  Widget title;
  Widget content;
  BuildContext context;
  List<Widget> actions;
  ShowDialogue({ this.context , this.title , this.content , this.actions }){
    showDialogue();
  }


  showDialogue() async {

    await showDialog(context: context , builder: (BuildContext buildContext) {
      return AlertDialog(
        title: title ,
        content: content ,
        actions: actions ,
      );
    },);
  }



}