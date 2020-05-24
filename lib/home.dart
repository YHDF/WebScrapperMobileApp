import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pfe_mobile/background.dart';
import 'package:pfe_mobile/bottom_bar.dart';
import 'package:pfe_mobile/product_detail.dart';
import 'package:pfe_mobile/profile.dart';
import 'package:pfe_mobile/user.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'Globals.dart' as globals;
import 'package:pfe_mobile/side.dart';

import 'favorite.dart';
import 'favorites.dart';
class Home extends StatefulWidget {


  HomeState createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home> {
  Future<void> _launched;
  double dev_width, dev_height;
  final Color selectedcolor = globals.MyGlobals.darkcolor;
  final Color unselectedcolor = globals.MyGlobals.lightcolor;
  static bool selected = true;
  static bool unselected = false;
  static List<bool> lst_selectedchoice = new List<bool>();
  static List<Color> lst_selectedchoicecolor = new List<Color>();
  static Color computer_color, phone_color;
  static bool computer_selected, phone_selected,phone_rotated;
  static int counter = 0;
  static int first_counter = 0;


  void initState() {
    super.initState();
    get_user_data();
    getfavorites();
    lst_selectedchoice.insert(0, selected);
    lst_selectedchoice.insert(1, unselected);
    for (int i = 0; i < 2; i++) {
      lst_selectedchoicecolor.insert(
          i, lst_selectedchoice[i] ? selectedcolor : unselectedcolor);
    }
    computer_selected = phone_selected = true;
    computer_color = phone_color =  globals.MyGlobals.darkcolor;
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
    });
  }

  static void get_user_data() async{
    await Future<Profile>(() async {
      final response = await http.get('${globals.MyGlobals.link_start}/api/user?api_token=${globals.MyGlobals.api_token}');
      if (response.statusCode == 200) {
        return Profile.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Profile');
      }
    }).then((value) {
      globals.MyGlobals.favorite_count = value.favorite_count;
      globals.MyGlobals.feedback_count = value.feedback_count;
      globals.MyGlobals.current_user = User.fromJson(value.user);
    });
  }

  void change_color() {
    setState(() {
      for (int i = 0; i < 2; i++) {
        lst_selectedchoicecolor[i] =
            lst_selectedchoice[i] ? selectedcolor : unselectedcolor;
      }
    });
  }

  Future<bool> _onpress() async {
    exit(0);
    return true;
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      print('Error: ${snapshot.error}');
      return Text('');
    } else {
      return const Text('');
    }
  }
  @override
  Widget build(BuildContext context) {
    dev_width = MediaQuery.of(context).size.width;
    dev_height = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: _onpress,
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Background(),
              new Stack(
                children: <Widget>[
                  Container(
                    height: dev_height / 10,
                    alignment: Alignment(0,1),
                    child: Container(
                      height: dev_height / 18,
                      alignment: Alignment(0,1),
                      child: Container(
                        width: 0.9 * dev_width,
                        height: dev_height / 18,
                        decoration: BoxDecoration(
                          color: globals.MyGlobals.lightcolor.withOpacity(0),
                          border: Border.all(
                            color: globals.MyGlobals.lightcolor,
                            width: 0.3,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 0.9 * dev_width / 2.1,
                              child: FlatButton(
                                onPressed: () {
                                  selected = true;
                                  unselected = false;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                  );
                                },
                                child:Center(
                                  child: Text(
                                    'Our Choice',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: lst_selectedchoicecolor[0],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            VerticalDivider(width: dev_width / 41.2,color: globals.MyGlobals.lightcolor,indent: 8,endIndent: 8,),
                            Container(
                              width: 0.9 * dev_width / 2.1,
                              child: FlatButton(
                                onPressed: () {
                                  selected = false;
                                  unselected = true;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                  );
                                },
                                child: Center(
                                  child: Text(
                                    'Most Visited',
                                    style: TextStyle(
                                      fontSize: dev_height > dev_width ? dev_width / 27.46 : dev_height / 27.46,
                                      fontWeight: FontWeight.w300,
                                      color: lst_selectedchoicecolor[1],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment(0, 0.25),
                    child: Container(
                      width: dev_width,
                      height: 14.5 * dev_height / 18,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(color: globals.MyGlobals.lightcolor,indent: dev_height > dev_width ? dev_width / 16.48
                              : dev_height / 16.48 ,endIndent: dev_height > dev_width ? dev_width / 16.48
                                : dev_height / 16.48,),
                        itemCount: selected ? globals.MyGlobals.best_products.length : globals.MyGlobals.most_visited.length,
                        itemBuilder: (BuildContext context, int index) {
                          return FlatButton(
                            onPressed: (){
                              if(selected){
                                for(int i =0; i < globals.MyGlobals.all_products.length; i++){
                                  if(globals.MyGlobals.all_products[i].id_product == globals.MyGlobals.best_products[index].id_product){
                                    counter = i;
                                    break;
                                  }
                                }
                              }else{
                                for(int i =0; i < globals.MyGlobals.all_products.length; i++){
                                  if(globals.MyGlobals.all_products[i].id_product == globals.MyGlobals.most_visited[index].id_product){
                                    counter = i;
                                    break;
                                  }
                                }
                              }
                              first_counter = index;
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => product_detail(counter)),
                              );
                            },
                            child: Container(
                              height: dev_height / 8.13,
                              decoration: BoxDecoration(
                                color: globals.MyGlobals.lightcolor.withOpacity(0),
                                border: Border.all(
                                  color: Colors.transparent,
                                  width: 0,
                                ),
                                borderRadius: BorderRadius.circular(dev_width / 41.2),
                              ),
                              child: Row(
                                children: <Widget>[
                                  VerticalDivider(width: dev_width / 41.2,color: Colors.transparent,),
                                  Container(
                                    width: dev_width / 5,
                                    height: dev_height / 9.76,
                                    child: Image.network(
                                      selected ? globals.MyGlobals.best_products[index].image : globals.MyGlobals.most_visited[index].image,
                                    ),
                                  ),
                                  VerticalDivider(width: dev_width / 41.2,color: Colors.transparent,),
                                  Container(
                                    width: 2 * dev_width / 3.3,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: dev_height / 14.64,
                                          child: Center(
                                            child: Text(
                                              selected ? globals.MyGlobals.best_products[index].name : globals.MyGlobals.most_visited[index].name,
                                              style: TextStyle(
                                                color: globals.MyGlobals.lightcolor,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: dev_height / 20.91,
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                width: dev_width / 6,
                                                alignment: Alignment(1,0),
                                                child: Text(
                                                  selected ? globals.MyGlobals.best_products[index].price.toString() + "\$" : globals.MyGlobals.most_visited[index].price.toString() + "\$",
                                                  style: TextStyle(
                                                    color: globals.MyGlobals.lightcolor,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                              VerticalDivider(width : dev_height / 22,color: Colors.transparent,),
                                              Container(
                                                width: dev_width / 3,
                                                alignment: Alignment(1,0),
                                                child: FlatButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _launched = _launchInBrowser(selected ? globals.MyGlobals.best_products[index].link.toString() : globals.MyGlobals.most_visited[index].link.toString());
                                                    });
                                                  },
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Container(
                                                        alignment: Alignment(0,0),
                                                        child: Text(
                                                            'visit in website',
                                                          style: TextStyle(
                                                            color: globals.MyGlobals.lightcolor,
                                                            fontWeight: FontWeight.w300,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        alignment: Alignment(1,0),
                                                        child: Icon(
                                                            IconData(58849, fontFamily: 'MaterialIcons', matchTextDirection: true),
                                                          color: globals.MyGlobals.lightcolor,
                                                          size: dev_width / 41.2,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              FutureBuilder<void>(future: _launched, builder: _launchStatus),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },

                      ),
                    ),
                  )
                ],
              ),
              bottom_bar(),
            ],
          ),
          drawer: side_bar(),
        ),
    );
  }
}
