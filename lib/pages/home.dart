import 'package:flutter/material.dart';

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
        onPressed: () { 
          Navigator.pushReplacementNamed(context, '/wall', arguments: {
            'name': 'Wall Drying'
          });
        },
        backgroundColor: Colors.green[600],
        child: Text('Start'),
      ),
    );
  }
}