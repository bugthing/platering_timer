import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  title: 'Plastering Timer',
  theme: new ThemeData(scaffoldBackgroundColor: Colors.blueAccent),
  home: Home(),
));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Plastering Timer'),
          centerTitle: true,
          backgroundColor: Colors.blue[600]
      ),
      body: Center(
        child: Text(
          'Lets time some plaster drying',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { print('Clicked Start'); },
        backgroundColor: Colors.green[600],
        child: Text('Start'),
      ),
    );
  }
}