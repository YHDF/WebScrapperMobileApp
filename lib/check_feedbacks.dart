import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe_mobile/background.dart';
import 'package:pfe_mobile/device_dimensions.dart';
import 'bottom_bar.dart';
import 'feed.dart';
import 'feeds.dart';
import 'side.dart';
import 'Globals.dart' as globals;



class Myfeedbacks extends StatefulWidget {
  MyfeedbacksState createState() => MyfeedbacksState();
}
class MyfeedbacksState extends State<Myfeedbacks>{
  double dev_width,dev_height;
  Color onpressedcolor;
  List<bool> isFavorite = new List<bool>(globals.MyGlobals.favourites.length);
  @override
  void initState(){
    super.initState();
    setState(() {
      get_feedbacks();
    });
    //getfavorites();
  }

  void get_feedbacks() async{
    await Future<Feeds>(() async {
      final response = await http.get('${globals.MyGlobals.link_start}/api/feedback?api_token=${globals.MyGlobals.api_token}');
      if (response.statusCode == 200) {
        return Feeds.fromJson(json.decode(response.body));
      }else {
        throw Exception('Failed to load Feedbacks');
      }
    }).then((value) {
      globals.MyGlobals.feeds.clear();
      value.feeds.forEach((element) {globals.MyGlobals.feeds.add(Feed.fromJson(element));
      });
    });
  }

  Future<bool> _onpress() async{
    setState(() {
      bottom_barState.page_counter = 1;
      side_barState.lst_selected_side[2] = false;
      Navigator.pop(context);
    });
    return true;
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
            Background(),
            Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment(0,-0.9),
                  child: Container(
                    width: 3 * dev_width / 4,
                    height:  dev_height / 12,
                    alignment: Alignment(0,0),
                    child: Container(
                      alignment: Alignment(0,0),
                      height: dev_height / 18,
                      width: 2 * dev_width / 3,
                      decoration: BoxDecoration(
                        color: globals.MyGlobals.lightcolor.withOpacity(0),
                        border:  Border.all(color: globals.MyGlobals.lightcolor,width: 0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Feedbacks :',
                        style: TextStyle(fontSize: dev_height / 24.4, color: globals.MyGlobals.lightcolor,fontWeight: FontWeight.w200),
                      ),
                    ),
                  ),
                ),
                globals.MyGlobals.feeds.length > 0 ? Container(
                  alignment: Alignment(-1, 0.1),
                  child: Container(
                    width:  dev_width,
                    height: 14 * dev_height / 18,
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(color: globals.MyGlobals.lightcolor,endIndent: 25,indent: 25,),
                      itemCount: globals.MyGlobals.feeds.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: globals.MyGlobals.lightcolor.withOpacity(0),
                            border: Border.all(
                              color: Colors.transparent,
                              width: 0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      height: dev_height / 16,
                                      alignment: Alignment(0,0),
                                      child: Text(
                                        'Subject:  ',
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: dev_height > dev_width ? dev_height / 20.91 : dev_width / 20.91,
                                          color: globals.MyGlobals.darkcolor,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: dev_height / 16,
                                      alignment: Alignment(0,0),
                                      child: Text(
                                        globals.MyGlobals.feeds[index].subject,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: globals.MyGlobals.lightcolor,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      height: dev_height / 16,
                                      alignment: Alignment(0,0),
                                      child: Text(
                                        'Body:  ',
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 35,
                                          color: globals.MyGlobals.darkcolor,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: dev_height / 16,
                                      alignment: Alignment(0,0),
                                      child: Text(
                                        globals.MyGlobals.feeds[index].text,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: globals.MyGlobals.lightcolor,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ) : Center(child: Text(
                  'No Feedbacks Found !',
                  style: TextStyle(color: globals.MyGlobals.lightcolor,fontWeight: FontWeight.w100,fontSize: 25),
                ),),
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