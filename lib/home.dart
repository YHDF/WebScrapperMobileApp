import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pfe_mobile/bottom_bar.dart';
import 'package:pfe_mobile/product_detail.dart';
import 'package:pfe_mobile/profile.dart';
import 'package:pfe_mobile/user.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'Globals.dart' as globals;
import 'package:pfe_mobile/side.dart';
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
  static int j = 0;


  void initState() {
    super.initState();
    get_user_data();
    lst_selectedchoice.insert(0, selected);
    lst_selectedchoice.insert(1, unselected);
    for (int i = 0; i < 2; i++) {
      lst_selectedchoicecolor.insert(
          i, lst_selectedchoice[i] ? selectedcolor : unselectedcolor);
    }
    computer_selected = phone_selected = true;
    computer_color = phone_color =  globals.MyGlobals.darkcolor;
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
              bottom_bar(),
              new Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment(0, -0.9),
                    child: Container(
                      width: 0.9 * dev_width,
                      height: dev_height / 18,
                      decoration: BoxDecoration(
                        color: globals.MyGlobals.lightcolor.withOpacity(0.4),
                        border: Border.all(
                          color: Colors.transparent,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 0.9 * dev_width / 2,
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
                              child: Center(
                                child: Text(
                                  'Our Choice',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: lst_selectedchoicecolor[0],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 0.9 * dev_width / 2,
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
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
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
                  Container(
                    alignment: Alignment(0, -0.75),
                    child: Container(
                      width: 0.9 * dev_width,
                      height: dev_height / 18,
                      child: Center(
                        child: Container(
                          width: 0.5 * dev_width,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 0.5 * dev_width / 2,
                                alignment: Alignment(0, 0),
                                child: FlatButton(
                                  onPressed: (){
                                    setState(() {
                                      if(computer_selected){
                                        computer_selected = false;
                                        computer_color = globals.MyGlobals.lightcolor;
                                      }else{
                                        computer_selected = true;
                                        computer_color = globals.MyGlobals.darkcolor;
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: 0.5 * dev_width / 4,
                                    height: dev_height / 18,
                                    decoration: BoxDecoration(
                                      color: globals.MyGlobals.lightcolor.withOpacity(0.2),
                                      border: Border.all(
                                          color: Colors.transparent, width: 0),
                                      borderRadius:
                                      BorderRadius.circular(0.5 * dev_width),
                                    ),
                                    child: Icon(
                                      IconData(58122, fontFamily: 'MaterialIcons'),
                                      color: computer_color,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 0.5 * dev_width / 2,
                                alignment: Alignment(0, 0),
                                child: FlatButton(
                                  onPressed: (){
                                    setState(() {
                                      if(phone_selected){
                                        phone_selected = false;
                                        phone_color = globals.MyGlobals.lightcolor;
                                      }else{
                                        phone_selected = true;
                                        phone_color = globals.MyGlobals.darkcolor;
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: 0.5 * dev_width / 4,
                                    height: dev_height / 18,
                                    decoration: BoxDecoration(
                                      color: globals.MyGlobals.lightcolor.withOpacity(0.2),
                                      border: Border.all(
                                          color: Colors.transparent, width: 0),
                                      borderRadius:
                                      BorderRadius.circular(0.5 * dev_width),
                                    ),
                                    child: Icon(
                                      IconData(58148, fontFamily: 'MaterialIcons'),
                                      color: phone_color,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment(0, 0.3),
                    child: Container(
                      width: dev_width,
                      height: 13 * dev_height / 18,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: selected ? globals.MyGlobals.best_products.length : globals.MyGlobals.most_visited.length,
                        itemBuilder: (BuildContext context, int index) {
                          return FlatButton(
                            onPressed: (){
                              if(selected){
                                for(int i =0; i < globals.MyGlobals.all_products.length; i++){
                                  if(globals.MyGlobals.all_products[i].id_product == globals.MyGlobals.best_products[index].id_product){
                                    j = i;
                                    break;
                                  }
                                }
                              }else{
                                for(int i =0; i < globals.MyGlobals.all_products.length; i++){
                                  if(globals.MyGlobals.all_products[i].id_product == globals.MyGlobals.most_visited[index].id_product){
                                    j = i;
                                    break;
                                  }
                                }
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => product_detail(j)),
                              );
                            },
                            child: Container(
                              height: 90,
                              decoration: BoxDecoration(
                                color: globals.MyGlobals.lightcolor.withOpacity(0.3),
                                border: Border.all(
                                  color: Colors.transparent,
                                  width: 0,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: <Widget>[
                                  VerticalDivider(width: 10,),
                                  Container(
                                    width: dev_width / 5,
                                    height: 75,
                                    child: Image.network(
                                      selected ? globals.MyGlobals.best_products[index].image : globals.MyGlobals.most_visited[index].image,
                                    ),
                                  ),
                                  VerticalDivider(width: 10,),
                                  Container(
                                    width: 2 * dev_width / 3.3,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 50,
                                          child: Center(
                                            child: Text(
                                              selected ? globals.MyGlobals.best_products[index].name : globals.MyGlobals.most_visited[index].name,
                                              style: TextStyle(
                                                color: globals.MyGlobals.lightcolor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 35,
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                width: dev_width / 6,
                                                alignment: Alignment(1,0),
                                                child: Text(
                                                  selected ? globals.MyGlobals.best_products[index].price.toString() + "\$" : globals.MyGlobals.most_visited[index].price.toString() + "\$",
                                                  style: TextStyle(
                                                    color: globals.MyGlobals.lightcolor
                                                  ),
                                                ),
                                              ),
                                              VerticalDivider(width : 40),
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
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        alignment: Alignment(1,0),
                                                        child: Icon(
                                                            IconData(58849, fontFamily: 'MaterialIcons', matchTextDirection: true),
                                                          color: globals.MyGlobals.lightcolor,
                                                          size: 15,
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
                        separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          drawer: side_bar(),
        ),
    );
  }
}
