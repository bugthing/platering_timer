import 'package:flutter/material.dart';
import 'dart:async';
import 'package:plasteringtimer/services/wall_time.dart';
import 'package:plasteringtimer/services/wall_timer_heading.dart';

class WallTimer extends StatefulWidget {
  @override
  _WallTimerState createState() => _WallTimerState();
}

class _WallTimerState extends State<WallTimer> {

  WallTime wall = WallTime();
  Map data = {};
  Timer _timer;

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

  void stopTimer() {
    setState( () { _timer.cancel(); });
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

    if ( wall.isNewStage ) {
      print("Play sounds, just moved onto next stage");
    }

    List<Widget> rows = wall.stages.map((stage) {
      return Column(children: <Widget>[
        Text(
          stage.title, 
          style: TextStyle(
            color: stage.isActive ? Colors.green : (stage.hasExpired ? Colors.grey : Colors.purple), 
            fontSize: 20.0,
            backgroundColor: Colors.lightBlue[50],
           ),
        ),
        Text(
          stage.summary,
          style: TextStyle(color: stage.isActive ? Colors.black : Colors.grey, fontSize: 20.0)
        ),
      ]);
    }).toList();

    return Scaffold(
      appBar: AppBar(
          title: Text(wall.name),
          centerTitle: true,
          backgroundColor: Colors.blue[600]
      ),
      body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: WallTimerHeading(wall: this.wall),
              floating: true,
              expandedHeight: 80,
              centerTitle: true,
              stretch: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index >= rows.length) return null;
                  return rows[index];
               },
              )
            ),
          ],
        ),
      floatingActionButton:Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () { 
                Navigator.pushReplacementNamed(context, '/');
              },
              backgroundColor: Colors.red[600],
              child: Text('Stop'),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () { 
                if ( _timer != null && _timer.isActive ) {
                  stopTimer();
                } else {
                  startTimer();
                }
              },
              backgroundColor: Colors.green[600],
              child: Icon( ( _timer != null && _timer.isActive) ? Icons.pause : Icons.play_arrow ),
            ),
          ),
        ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}