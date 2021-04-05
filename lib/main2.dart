import 'package:cameratest/main.dart';
import 'package:flutter/material.dart';

class Main2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Route'),
      ),
        body: Container(
      child: TextButton(
        child: Text('First Page'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        },
      ),
    ));
  }
}
