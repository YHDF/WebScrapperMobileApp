import 'package:flutter/material.dart';

class Background extends StatefulWidget {
  BackgroundState createState() => BackgroundState();
}

class BackgroundState extends State<Background> {
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0, -1),
          end: Alignment(0, 0.5),
          colors: [
            const Color.fromRGBO(236, 111, 102, 1),
            const Color.fromRGBO(243, 161, 131, 1),
          ], // whitish to gray
        ),
      ),
    );
  }
}
