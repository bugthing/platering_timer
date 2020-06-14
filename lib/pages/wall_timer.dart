import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'dart:async';
import 'package:plasteringtimer/services/wall_time.dart';
import 'package:plasteringtimer/components/wall_timer_heading.dart';
import 'package:plasteringtimer/components/stage_row.dart';

class WallTimer extends StatefulWidget {
  @override
  _WallTimerState createState() => _WallTimerState();
}

class _WallTimerState extends State<WallTimer> {

  WallTime wall = WallTime();
  Map data = {};
  Timer _timer;
  static AudioCache _player = AudioCache();

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
      _player.play('sound/alarm.mp3');
    }

    List<StageRow> rows = wall.stages.map((stage) { return StageRow(stage: stage); }).toList();

    return Scaffold(
      appBar: AppBar(
          title: Text(wall.name),
          centerTitle: true,
          backgroundColor: Colors.blue[600]
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/plaster-wall.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: WallTimerHeading(wall: this.wall),
                floating: true,
                expandedHeight: 80,
                centerTitle: true,
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