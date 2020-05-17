import 'package:flutter/material.dart';
class clipping_auth extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height/2);
    path.quadraticBezierTo(size.width * 0.75 , size.height / 1.464, size.width/1.75, size.height/2.44);
    path.quadraticBezierTo(size.width  / 2, size.height/3.66, 0, size.height/2);
    path.lineTo(0, size.height/2);
    //path.moveTo(0, 300);
    /*path.quadraticBezierTo(size.width / 4, size.height / 3.66, size.width / 1.71, size.height / 2.44);
    path.quadraticBezierTo(size.width * 0.75, size.height / 1.464, size.width, size.height / 3.66);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);*/
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
