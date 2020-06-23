import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Background extends StatefulWidget {
  BackgroundState createState() => BackgroundState();
}

class BackgroundState extends State<Background> {
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //color: Color.fromRGBO(189, 189, 189, 1)
        gradient: LinearGradient(
          begin: Alignment(0, 0),
          end: Alignment(0, 1),
          colors: [
            const Color.fromRGBO(134, 143, 150, 1),
            const Color.fromRGBO(89, 97, 100, 1),
          ], // whitish to gray
        ),
      ),
    );
  }
}
