import 'package:flutter/material.dart';
import 'dart:async';
import 'package:plasteringtimer/services/wall_time.dart';

class WallTimer extends StatefulWidget {
  @override
  _WallTimerState createState() => _WallTimerState();
}

class _WallTimerState extends State<WallTimer> {

  WallTime wall = WallTime();
  Map data = {};
  Timer _timer;
  int _seconds = 0;
  IconData icon = Icons.play_arrow;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          wall.tick();
        },
      ),
    );
  }

  @override
  void dispose() {
    if ( _timer != null ) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    wall.name = data['name'];

    if ( wall.isNewStage() ) {
      print("Play sounds, just moved onto next stage");
    }

    return Scaffold(
      appBar: AppBar(
          title: Text(wall.name),
          centerTitle: true,
          backgroundColor: Colors.blue[600]
      ),
      body: Container(
        child: Column(
          children: [ 
            Row(
              children: [
                Text(
                  wall.title(),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  )
                ),
               ]
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(icon),
                  onPressed: () {
                    if ( _timer != null && _timer.isActive ) {
                      _timer.cancel();
                    } else {
                      // start pressed
                      icon = Icons.pause;
                      startTimer();
                    }
                  },
                ),
              ]
            ) 
           ]
        )
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