import 'package:flutter/material.dart';
class device_dimensions {
  double dev_width;
  double dev_height;
  device_dimensions(BuildContext context){
    dev_width = MediaQuery.of(context).size.width;
    dev_height = MediaQuery.of(context).size.height;
  }
}