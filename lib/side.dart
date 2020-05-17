import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pfe_mobile/bottom_bar.dart';
import 'package:pfe_mobile/favorite.dart';
import 'package:pfe_mobile/favorites.dart';
import 'package:pfe_mobile/search.dart';
import 'package:pfe_mobile/settings.dart';
import 'package:pfe_mobile/user_favorites.dart';
import 'package:pfe_mobile/user_profile.dart';
import 'package:pfe_mobile/client_reclamations.dart';
import 'Globals.dart' as globals;
import 'package:http/http.dart' as http;

class side_bar extends StatefulWidget {
  side_barState createState() => side_barState();
}

class side_barState extends State<side_bar> with TickerProviderStateMixin{
  static List<Color> lst_colors_side = new List<Color>();
  static List<bool> lst_selected_side = new List<bool>();
  static bool visible = false;
  static double drawer_width;
  static bool modified = false;
  AnimationController bg_color_controller;
  Animation<double> bg_color_anim;
  final double minG = 130;
  static double G = 0;

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
        G = minG + bg_color_anim.value / 2 ;
      });
    });
    bg_color_controller.repeat(reverse: true);
    drawer_width = 75;
    if(!modified){
      for (int i = 0; i < 5; i++) {
        lst_colors_side.insert(i, globals.MyGlobals.lightcolor);
        lst_selected_side.insert(i, false);
      }
    }
    modified = true;
  }

  @override
  void dispose(){
    bg_color_controller.dispose();
    super.dispose();
  }
  void change_color_side() {
    setState(() {
      for (int i = 0; i < 5; i++) {
        if (lst_selected_side[i] == true) {
          lst_colors_side[i] = globals.MyGlobals.darkcolor;
        } else {
          if (lst_selected_side[i] == false) {
            lst_colors_side[i] = globals.MyGlobals.lightcolor;
          }
        }
      }
    });
  }
  void getfavorites() async{
    await Future<Favourites> (() async {
      final response = await http.get('${globals.MyGlobals.link_start}/api/favourite?api_token=${globals.MyGlobals.api_token}');
      if (response.statusCode == 200) {
        return Favourites.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Favourite');
      }
    }).then((value) {
      globals.MyGlobals.favourites.clear();
      value.favourites.forEach((element) {
        globals.MyGlobals.favourites.add(Favorite.fromJson(element));
      });
      visible = false;
      for(int i = 0; i < 5; i++){
        lst_selected_side[i] = false;
      }
      lst_selected_side[3] = true;
      change_color_side();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => user_favorite()),
      );
    });
  }
  void change_visibility() {
    setState(() {
      if (drawer_width == 75) {
        drawer_width = 225;
      } else {
        drawer_width = 75;
      }
      if (visible == false) {
        visible = true;
      } else {
        visible = false;
      }
    });
  }

  Widget build(BuildContext context) {
    change_color_side();
    if (bottom_barState.page_counter == 1) {
      bottom_barState.page_counter = 0;
      setState(() {
        change_color_side();
      });
    }
    return Container(
      width: drawer_width,
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(230, G.round(), 130, 1),
          ),
          child: ListView(
            children: <Widget>[
              Container(
                child: ListTile(
                  contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  title: Row(
                    children: <Widget>[
                      Container(
                        width: drawer_width == 75
                            ? drawer_width
                            : drawer_width / 2,
                        alignment: Alignment(0, 1),
                        child: Icon(
                          IconData(59475, fontFamily: 'MaterialIcons'),
                          size: 40,
                          color: lst_colors_side[0],
                        ),
                      ),
                      Container(
                        width: drawer_width == 75 ? 0 : drawer_width / 2,
                        alignment: Alignment(-1, 1),
                        child: Visibility(
                          visible: visible,
                          child: Container(
                            child: Text(
                              'Profile',
                              style: TextStyle(
                                fontSize: 25,
                                color: lst_colors_side[0],
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    visible = false;
                    for(int i = 0; i < 5; i++){
                      lst_selected_side[i] = false;
                    }
                    lst_selected_side[0] = true;
                    change_color_side();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => user_profile()),
                    );
                  },
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                title: Row(
                  children: <Widget>[
                    Container(
                      width:
                      drawer_width == 75 ? drawer_width : drawer_width / 2,
                      alignment: Alignment(0, 1),
                      child: Icon(
                        IconData(59574, fontFamily: 'MaterialIcons'),
                        size: 40,
                        color: lst_colors_side[1],
                      ),
                    ),
                    Container(
                      width: drawer_width == 75 ? 0 : drawer_width / 2,
                      alignment: Alignment(-1, 1),
                      child: Visibility(
                        visible: visible,
                        child: Container(
                          child: Text(
                            'Search',
                            style: TextStyle(
                              fontSize: 25,
                              color: lst_colors_side[1],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  visible = false;
                  setState(() {
                    for(int i = 0; i < 5; i++){
                      lst_selected_side[i] = false;
                    }
                    lst_selected_side[1] = true;
                    bottom_barState.bottomsearchclicked = false;
                    change_color_side();
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => search()),
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                title: Row(
                  children: <Widget>[
                    Container(
                      width:
                      drawer_width == 75 ? drawer_width : drawer_width / 2,
                      alignment: Alignment(0, 1),
                      child: Icon(
                        IconData(57344, fontFamily: 'MaterialIcons'),
                        size: 40,
                        color: lst_colors_side[2],
                      ),
                    ),
                    Container(
                      width: drawer_width == 75 ? 0 : drawer_width / 2,
                      alignment: Alignment(-1, 1),
                      child: Visibility(
                        visible: visible,
                        child: Container(
                          child: Text(
                            'Complaint',
                            style: TextStyle(
                              fontSize: 25,
                              color: lst_colors_side[2],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  visible = false;
                  setState(() {
                    for(int i = 0; i < 5; i++){
                      lst_selected_side[i] = false;
                    }
                    lst_selected_side[2] = true;
                    change_color_side();
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => client_reclamation()),
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                title: Row(
                  children: <Widget>[
                    Container(
                      width:
                      drawer_width == 75 ? drawer_width : drawer_width / 2,
                      alignment: Alignment(0, 1),
                      child: Icon(
                        IconData(59517, fontFamily: 'MaterialIcons'),
                        size: 40,
                        color: lst_colors_side[3],
                      ),
                    ),
                    Container(
                      width: drawer_width == 75 ? 0 : drawer_width / 2,
                      alignment: Alignment(-1, 1),
                      child: Visibility(
                        visible: visible,
                        child: Container(
                          child: Text(
                            'Favorites',
                            style: TextStyle(
                              fontSize: 25,
                              color: lst_colors_side[3],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  getfavorites();
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                title: Row(
                  children: <Widget>[
                    Container(
                      width:
                      drawer_width == 75 ? drawer_width : drawer_width / 2,
                      alignment: Alignment(0, 1),
                      child: Icon(
                        IconData(59576, fontFamily: 'MaterialIcons'),
                        size: 40,
                        color: lst_colors_side[4],
                      ),
                    ),
                    Container(
                      width: drawer_width == 75 ? 0 : drawer_width / 2,
                      alignment: Alignment(-1, 1),
                      child: Visibility(
                        visible: visible,
                        child: Container(
                          child: Text(
                            'Settings',
                            style: TextStyle(
                              fontSize: 25,
                              color: lst_colors_side[4],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  visible = false;
                  setState(() {
                    for(int i = 0; i < 5; i++){
                      lst_selected_side[i] = false;
                    }
                    lst_selected_side[4] = true;
                    change_color_side();
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => settings()),
                  );
                },
              ),
              Container(
                height: bottom_barState.dev_height / 2,
                alignment: Alignment(1, 1),
                child: Container(
                  height: 75,
                  child: ListTile(
                    title: Icon(
                      IconData(58391, fontFamily: 'MaterialIcons'),
                      size: 35,
                      color: globals.MyGlobals.lightcolor,
                    ),
                    onTap: () {
                      setState(() {
                        change_visibility();
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
