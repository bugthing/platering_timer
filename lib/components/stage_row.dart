import 'package:flutter/material.dart';
import 'package:plasteringtimer/services/wall_time.dart';

class StageRow extends StatelessWidget {
  Stage stage;

  StageRow({this.stage});

  get bgColour {
    return stage.isActive ? Colors.green : (stage.hasExpired ? Colors.teal : Colors.blue);
  }

  get borderColour {
    return stage.isActive ? Colors.greenAccent : (stage.hasExpired ? Colors.tealAccent : Colors.blueAccent);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: bgColour,
        border: Border.all(
          color: borderColour,
          width: 4,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: <Widget>[
        Text(stage.title,style: TextStyle(fontSize: 20.0)),
        Text(stage.summary),
      ])
    );
  }
}