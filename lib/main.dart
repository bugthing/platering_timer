import 'dart:async';
import 'package:flutter/material.dart';
//import 'models/timer_model.dart';


//void main() {
//  runApp(new MaterialApp(
//    debugShowCheckedModeBanner: false,
//    home: new MyApp(),
//  ));
//}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Plastering Timer'),
      ),
      body: new Container(
        color: Colors.blueAccent,
        padding: new EdgeInsets.all(32.0),
        child: new MyAppLayout(),
      ),
    );
  }
}

class MyAppLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        new ProgressIndicatorDemo(),
        Text('----------'),
        //TimerModel().items,
        MaterialButton(
          child: Text('Go'),
          shape: CircleBorder(),
          padding: EdgeInsets.all(30.0),
          color: Colors.greenAccent,
          onPressed: () {
            //Do something
          },
        )
      ],
    );
  }
}

class StageRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.home),
      ],
    );
  }
}


class ProgressIndicatorDemo extends StatefulWidget {

  @override
  _ProgressIndicatorDemoState createState() =>
      new _ProgressIndicatorDemoState();
}

class _ProgressIndicatorDemoState extends State<ProgressIndicatorDemo>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
          child:  LinearProgressIndicator( value:  animation.value,),

        )
    );
  }
}