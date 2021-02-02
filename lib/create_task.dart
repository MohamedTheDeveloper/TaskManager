import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CreateTask extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  Color pickerColor = Colors.red;
  Color currentColor = Color(0xff443a49);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          margin: EdgeInsets.all( 16 ),
          child: Column(
            children: [
              Text("Enter task name"),
              TextField(
                controller: textEditingController,
              ),
              SingleChildScrollView(
                child: BlockPicker (
                  pickerColor: pickerColor,
                  onColorChanged: changeColor ,
                ),
              ),
              RaisedButton(
                child: Text("OK"),
                onPressed: () {

                  Navigator.pop(context , <int , dynamic>{
                    0 : textEditingController.text  ,
                    1 : currentColor.value ,
                  }    );
                },
              ),
              RaisedButton(
                child: Text("CANEL"),
                onPressed: () {
                  Navigator.pop( context  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeColor(Color value) {
    currentColor = value;
  }
}
