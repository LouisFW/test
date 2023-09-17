import 'package:flutter/material.dart';
import 'package:pertemuanempat/profil.dart';

class About extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text('About'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.home),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('image/ftiuntar.png'),
          Image.asset('image/logo.png'),
          Profil(),
        ],
      ),
    );
  }
}