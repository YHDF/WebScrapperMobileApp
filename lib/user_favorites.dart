import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pfe_mobile/device_dimensions.dart';
import 'package:pfe_mobile/favorite.dart';
import 'package:pfe_mobile/favorites.dart';
import 'package:pfe_mobile/message.dart';
import 'package:pfe_mobile/product_detail.dart';
import 'bottom_bar.dart';
import 'side.dart';
import 'package:http/http.dart' as http;
import 'Globals.dart' as globals;



class user_favorite extends StatefulWidget {
  user_favoriteState createState() => user_favoriteState();
}
class user_favoriteState extends State<user_favorite>{
  double dev_width,dev_height;
  Color onpressedcolor;
  List<bool> isFavorite = new List<bool>(globals.MyGlobals.favourites.length);
  @override
  void initState(){
    super.initState();
    //getfavorites();
    for(int i = 0; i < isFavorite.length; i++){
      isFavorite[i] = true;
    }
  }
  Future<bool> _onpress() async{
    setState(() {
      bottom_barState.page_counter = 1;
      side_barState.lst_selected_side[3] = false;
      Navigator.pop(context);
    });
    return true;
  }

  void delete_favorite(int index) async{
    await Future<Message>(() async{
      final response = await http.delete('${globals.MyGlobals.link_start}/api/favourite?api_token=${globals.MyGlobals.api_token}&favourite_id=${globals.MyGlobals.favourites[index].id_favorite}');
      if (response.statusCode == 200) {
        return Message.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Message');
      }
    }).then((value){
      setState(() {
        getfavorites();
      });
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
        setState(() {
          globals.MyGlobals.favourites.add(Favorite.fromJson(element));
        });
      });
    });
  }
  @override
  Widget build(BuildContext context){
    //getfavorites();
    dev_width = device_dimensions(context).dev_width;
    dev_height = device_dimensions(context).dev_height;
    return WillPopScope(
      onWillPop: _onpress,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            bottom_bar(),
            Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment(0,-0.9),
                  child: Container(
                    width: 3 * dev_width / 4,
                    height:  dev_height / 12,
                    alignment: Alignment(1,0),
                      child: Row(
                      children: <Widget>[
                        Container(
                          width: dev_height > dev_width ? dev_width / 7 : dev_height / 7,
                          height: dev_height > dev_width ? dev_width / 7 : dev_height / 7,
                          decoration: BoxDecoration(
                            color: globals.MyGlobals.lightcolor.withOpacity(0.5),
                            border:  Border.all(color: Colors.transparent,width: 0.0),
                            borderRadius: BorderRadius.circular(dev_width),
                          ),
                          child: Center(
                            child: Icon(
                                IconData(59517, fontFamily: 'MaterialIcons'),
                              color: globals.MyGlobals.lightcolor,
                              size: 30,
                            ),
                          ),
                        ),
                        VerticalDivider(width: 5,color: Colors.transparent,),
                        Container(
                          alignment: Alignment(0,0),
                          width:  dev_width /  1.8,
                          height: dev_height / 20,
                          decoration: BoxDecoration(
                            color: globals.MyGlobals.lightcolor.withOpacity(0.5),
                            border:  Border.all(color: Colors.transparent,width: 0.0),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            'Favorites',
                            style: TextStyle(fontSize: 20, color: globals.MyGlobals.lightcolor,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment(-1, 0.3),
                  child: Container(
                    width:  dev_width,
                    height: 14 * dev_height / 18,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: globals.MyGlobals.favourites.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: <Widget>[
                            Container(
                              width : 0.8 * dev_width,
                              child: FlatButton(
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => product_detail(index)),
                                  );
                                },
                                child: Container(
                                  height: 75,
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
                                      Container(
                                        width: dev_width / 5,
                                        child: Image.network(
                                          globals.MyGlobals.favourites[index].image,
                                        ),
                                      ),
                                      Container(
                                        width: dev_width / 2,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              height: 35,
                                              child: Center(
                                                child: Text(
                                                  globals.MyGlobals.favourites[index].name,
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
                                                      globals.MyGlobals.favourites[index].price.toString() + '\$' ,
                                                      style: TextStyle(
                                                          color: globals.MyGlobals.lightcolor
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: dev_width / 3,
                                                    alignment: Alignment(1,0),
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
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 0.15 * dev_width,
                              height : 75,
                              decoration: BoxDecoration(
                                border : Border.all(color: Colors.transparent, width: 0.0),
                                color: globals.MyGlobals.lightcolor.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: FlatButton(
                                child: Icon(
                                  IconData(57675, fontFamily: 'MaterialIcons'),
                                  size: 30,
                                  color: globals.MyGlobals.lightcolor,
                                ),
                                onPressed: (){
                                  delete_favorite(index);
                                  setState(() {
                                    isFavorite[index] = false;
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        drawer: side_bar(),
      ),
    );
  }
}