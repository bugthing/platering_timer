import 'package:flutter/material.dart';
import 'package:plasteringtimer/services/wall_time.dart';

class WallTimerHeading extends StatelessWidget {
  WallTime wall;

  WallTimerHeading({this.wall});

  @override
  Widget build(BuildContext context) {

    List<Widget> lines = [Text('Click Play to start')];
    if(this.wall.started) {
      lines = [
        Text("Started: ${this.wall.startedAsString} (${this.wall.durationAsString} ago)"),
        Text(this.wall.countDown),
      ];
    }

    return Container(
      child: Column(
        children: lines
      )
    );
  }
}