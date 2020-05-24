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

  static double dev_width, dev_height;
  static int page_counter = 0;
  static bool bottomsearchclicked;
  static bool ishomepage = true;
  static bool visible = true;

  @override
  void dispose(){
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    dev_width = device_dimensions(context).dev_width;
    dev_height = device_dimensions(context).dev_height;
    return
        Container(
          alignment: Alignment(0,1),
          child: Visibility(
            visible: visible,
            child: Container(
              width: dev_width,
              height: dev_height / 13,
              alignment: Alignment(0,1),
              child: Container(
                width: dev_width,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: dev_width / 4,
                      child: FlatButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: Container(
                          child: Icon(
                            IconData(58834, fontFamily: 'MaterialIcons'),
                            color: globals.MyGlobals.lightcolor.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: dev_width / 4,
                      child: FlatButton(
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
                          child: Icon(
                            IconData(59530, fontFamily: 'MaterialIcons'),
                            color: globals.MyGlobals.lightcolor.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: dev_width / 4,
                      child: FlatButton(
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
                          child: Icon(
                            IconData(59574, fontFamily: 'MaterialIcons'),
                            color: globals.MyGlobals.lightcolor.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: dev_width / 5,
                      child: FlatButton(
                        onPressed: () {
                          exit(0);
                        },
                        child: Container(
                          child: Icon(
                            IconData(59564, fontFamily: 'MaterialIcons'),
                            color: globals.MyGlobals.lightcolor.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
        );
  }
}
