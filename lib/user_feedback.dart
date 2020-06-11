import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pfe_mobile/background.dart';
import 'package:pfe_mobile/bottom_bar.dart';
import 'package:pfe_mobile/check_feedbacks.dart';
import 'package:pfe_mobile/feed.dart';
import 'package:pfe_mobile/feeds.dart';
import 'package:pfe_mobile/side.dart';
import 'Globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'create_feedback.dart';
import 'device_dimensions.dart';


class User_Feedback extends StatefulWidget {
  User_FeedbackState createState() => User_FeedbackState();
}
class User_FeedbackState extends State<User_Feedback> with TickerProviderStateMixin {
  double dev_height, dev_width;
  AnimationController opacity_animator;
  Animation<double> opacity_animation;
  double opacity = 0;

  void initState(){
    super.initState();
    opacity_animator = AnimationController(vsync: this, duration: Duration(seconds: 1));
    opacity_animation = Tween<double>(begin: 0,end: 0.6).animate(
        CurvedAnimation(
          parent: opacity_animator,
          curve: Interval(0.5, 1, curve: Curves.linear),
        ));
    opacity_animator.addListener(() {
      setState(() {
        opacity = opacity_animation.value;
      });
    });
    opacity_animator.forward();
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => Myfeedbacks()));
      }
      );
  }

  void dispose(){
    opacity_animator.dispose();
    super.dispose();
  }

  Widget build(BuildContext context){
    dev_width = device_dimensions(context).dev_width;
    dev_height = device_dimensions(context).dev_height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(),
          Column(
            children: <Widget>[
              Divider(color: Colors.transparent,),
              Container(
                height: dev_height / 12,
                alignment: Alignment(0,0),
                child: Text("What's on your mind ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: dev_height > dev_width ?  dev_height / 20.91 : dev_width / 20.91,
                      fontWeight: FontWeight.w100,
                      color: globals.MyGlobals.lightcolor.withOpacity(opacity),
                    )
                ),
              ),
              Container(
                height: dev_height / 8,
                alignment: Alignment(0,0),
                child: Text("We care about your feedback.",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: dev_height > dev_width ?  dev_height / 20.91 : dev_width / 20.91,
                      fontWeight: FontWeight.w100,
                      color: globals.MyGlobals.lightcolor.withOpacity(opacity),
                    )
                ),
              ),
              Container(
                height: dev_height / 10,
                alignment: Alignment(0,0),
                child: Text("So help us improve.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: dev_height > dev_width ?  dev_height / 20.91 : dev_width / 20.91,
                      fontWeight: FontWeight.w100,
                      color: globals.MyGlobals.lightcolor.withOpacity(opacity),
                    )
                ),
              ),
              Divider(color: globals.MyGlobals.lightcolor,indent: dev_width / 10 ,endIndent: dev_width / 10,),
              Row(
                children: <Widget>[
                  Container(
                    width: dev_width / 2,
                    height: dev_height / 2,
                    alignment: Alignment(0,0),
                    child: Container(
                      height: dev_height / 4,
                      width: dev_width / 2.1,
                      decoration: BoxDecoration(
                        border: Border.all(color: globals.MyGlobals.lightcolor,width: 0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: FlatButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Create_Feedback()),
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Post Feedbacks !',style: TextStyle(
                              color: globals.MyGlobals.lightcolor.withOpacity(0.7),
                              fontSize: dev_height > dev_width ? dev_height / 25 : dev_width / 25,
                              fontWeight: FontWeight.w100,
                            ),
                              textAlign: TextAlign.center,
                            ),
                            Divider(color: Colors.transparent,),
                            Text(
                              'Create a new feedback !',style: TextStyle(
                              color: globals.MyGlobals.lightcolor,
                              fontSize: dev_height > dev_width ?  dev_height / 48.8 : dev_width / 48.8,
                              fontWeight: FontWeight.w200,
                            ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: dev_width / 2,
                    height: dev_height / 2,
                    alignment: Alignment(0,0),
                    child: Container(
                      width: dev_width / 2.1,
                      height: dev_height / 4,
                      decoration: BoxDecoration(
                        border: Border.all(color: globals.MyGlobals.lightcolor,width: 0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: FlatButton(
                        onPressed: (){
                          setState(() {
                            get_feedbacks();
                          });
                        },
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Check Feedbacks !',style: TextStyle(
                              color: globals.MyGlobals.lightcolor.withOpacity(0.7),
                              fontSize: dev_height > dev_width ?  dev_height / 25 : dev_width / 25,
                              fontWeight: FontWeight.w100,
                            ),
                              textAlign: TextAlign.center,
                            ),
                            Divider(color: Colors.transparent,),
                            Text(
                              'View your feedback history !',style: TextStyle(
                              color: globals.MyGlobals.lightcolor,
                              fontSize: dev_height > dev_width ?  dev_height / 48.8 : dev_width / 48.8,
                              fontWeight: FontWeight.w200,
                            ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          bottom_bar(),
        ],
      ),
      drawer: side_bar(),
    );
  }
}