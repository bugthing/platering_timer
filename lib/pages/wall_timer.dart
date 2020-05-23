import 'package:flutter/material.dart';

class WallTimer extends StatefulWidget {
  @override
  _WallTimerState createState() => _WallTimerState();
}

class _WallTimerState extends State<WallTimer> {

  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
          title: Text('Wall Timer'),
          centerTitle: true,
          backgroundColor: Colors.blue[600]
      ),
      body: Center(
        child: Text(
          data['name'],
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { 
          Navigator.pushReplacementNamed(context, '/');
        },
        backgroundColor: Colors.red[600],
        child: Text('Stop'),
      ),
    );
  }
}