import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AnimatedSizeClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(home: AnimateSizeStatefull());
  }
}

class AnimateSizeStatefull extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AnimateSizeState();
  }
}

class AnimateSizeState extends State  {
  List<String> textList = [
    "this is my list",
    "test this",
    "new test",
    "how are you",
    "welcome to the game"
  ];

  void _updateSize() {
    setState(() {
      if (!_large) {
        _size = 250;
        fontSize = 30;
      } else {
        _size = 150;
        fontSize = 20;
      }
      _large = !_large;
    });
  }

  double _size = 150.0;
  bool _large = false;
  int fontSize = 20;
/*
ListView.builder(
            itemCount: textList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return A(textList[index]);
            },
          ),
 */
  ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _updateSize,
        child: Center(
          child: ScrollablePositionedList.builder(
            scrollDirection: Axis.horizontal ,
            itemScrollController: _scrollController,
            itemCount: textList.length,
            itemBuilder: (context, index) {

              return A( textList[ index ] , ()async{
                _scrollController.scrollTo(index: index , duration: Duration(seconds: 1 ));
              });

            },
          )
        ),
      ),
    );
  }
}

class A extends StatefulWidget {
  String text;
  dynamic onTap;
  A(this.text , this.onTap );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return B(text , onTap );
  }
}

class B extends State with SingleTickerProviderStateMixin {
  String text;
  final dataKey = new GlobalKey();
  dynamic onTap;
  B(this.text , this.onTap );

  bool isLarge = false;
  int fontSize = 20;
  int width = 150;
  int height = 200;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     key: dataKey ,
      onTap: () async {
        await onTap();

        setState(() {
          if( ! isLarge ){
            width = 250;
            height = 400;
            isLarge = true;
          }else{
            width = 150;
            height = 200;
            fontSize = 20;
            isLarge = false;
          }

        });
      },
      child: Container(

        margin: EdgeInsets.all(16),

        child: AnimatedSize(
          curve: Curves.easeIn,
          vsync: this,
          duration: Duration(milliseconds: 500),
          child: Container(
            child:  Text(
              text,
              style: TextStyle(fontSize: fontSize.toDouble()),
            ),
            color: Colors.purple,
            width: width.toDouble(),
            height: height.toDouble(),
          ),
        ),
      ),
    );
  }
}
