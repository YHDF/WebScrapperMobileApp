import 'package:flutter/material.dart';
import 'dart:io';
import 'package:pfe_mobile/device_dimensions.dart';
import 'package:pfe_mobile/home.dart';
import 'package:pfe_mobile/search.dart';
import 'package:pfe_mobile/side.dart';
import 'Globals.dart' as globals;



class bottom_bar extends StatefulWidget {
  @override
  State<StatefulWidget> createState () => bottom_barState();
}

class bottom_barState extends State<bottom_bar> with TickerProviderStateMixin{

  AnimationController bg_color_controller;
  Animation<double> bg_color_anim;
  final double minG = 120;
  static double G = 0;
  static double dev_width, dev_height;
  static int page_counter = 0;
  static bool bottomsearchclicked;
  static bool ishomepage = true;
  static bool visible = true;

  @override
  void dispose(){
    bg_color_controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    bg_color_controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    bg_color_anim = Tween<double>(begin: 0, end:60).animate(CurvedAnimation(
      parent: bg_color_controller,
      curve: Interval(0,1,curve: Curves.linear),
    ));
    bg_color_controller.addListener(() {
      setState(() {
        G = minG +  bg_color_anim.value / 2 ;
      });
    });
    bg_color_controller.repeat(reverse: true);
  }


  @override
  Widget build(BuildContext context) {
    dev_width = device_dimensions(context).dev_width;
    dev_height = device_dimensions(context).dev_height;
    return
      Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(230, G.round(), 120, 1),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment(0, 1),
              child: Visibility(
                visible: visible,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0,
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: dev_width,
                  height: dev_height / 12,
                  child: Row(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: Container(
                          width: dev_width / 6,
                          child: Icon(
                            IconData(58834, fontFamily: 'MaterialIcons'),
                            color: globals.MyGlobals.lightcolor,
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          if(!side_barState.modified){
                            for(int i = 0; i < 5; i++){
                              side_barState.lst_selected_side.insert(i, false);
                            }
                          }else{
                            for(int i = 0; i < 5; i++){
                              side_barState.lst_selected_side[i] = false;
                            }
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home()),
                          );
                        },
                        child: Container(
                          width: dev_width / 6,
                          child: Icon(
                            IconData(59530, fontFamily: 'MaterialIcons'),
                            color: globals.MyGlobals.lightcolor,
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            HomeState.selected = true;
                            HomeState.unselected = false;
                            ishomepage = false;
                            bottomsearchclicked = true;
                            if(!side_barState.modified){
                              for(int i = 0; i < 5; i++){
                                side_barState.lst_selected_side.insert(i, i == 1 ? true : false);
                              }
                            }else{
                              for(int i = 0; i < 5; i++){
                                side_barState.lst_selected_side[i] =  i == 1 ? true : false;
                              }
                            }
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => search()),
                          );
                        },
                        child: Container(
                          width: dev_width / 6 - 3,
                          child: Icon(
                            IconData(59574, fontFamily: 'MaterialIcons'),
                            color: globals.MyGlobals.lightcolor,
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          exit(0);
                        },
                        child: Container(
                          width: dev_width / 6,
                          child: Icon(
                            IconData(59564, fontFamily: 'MaterialIcons'),
                            color: globals.MyGlobals.lightcolor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
}
