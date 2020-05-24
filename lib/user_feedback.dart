import 'package:flutter/material.dart';
import 'package:pfe_mobile/background.dart';
import 'package:pfe_mobile/bottom_bar.dart';
import 'package:pfe_mobile/side.dart';
import 'Globals.dart' as globals;
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
    opacity_animator = AnimationController(vsync: this, duration: Duration(seconds: 2));
    opacity_animation = Tween<double>(begin: 0,end: 1).animate(
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
                    style: TextStyle(
                      fontSize: 40,
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
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w100,
                      color: globals.MyGlobals.lightcolor.withOpacity(opacity),
                    )
                ),
              ),
              Container(
                height: dev_height / 10,
                alignment: Alignment(0,0),
                child: Text("So help us improve.",
                    style: TextStyle(
                      fontSize: 40,
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
                      width: dev_width / 2.2,
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
                        child: Container(
                          height: dev_height / 8,
                          alignment: Alignment(0,0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Post Feedbacks !',style: TextStyle(
                                color: globals.MyGlobals.lightcolor,
                                fontSize: 30,
                                fontWeight: FontWeight.w100,
                              ),
                                textAlign: TextAlign.center,
                              ),
                              Divider(color: Colors.transparent,),
                              Text(
                                'Create a new feedback !',style: TextStyle(
                                color: globals.MyGlobals.lightcolor,
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                              ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: dev_width / 2,
                    height: dev_height / 2,
                    alignment: Alignment(0,0),
                    child: Container(
                      width: dev_width / 2.2,
                      height: dev_height / 4,
                      decoration: BoxDecoration(
                        border: Border.all(color: globals.MyGlobals.lightcolor,width: 0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: FlatButton(
                        onPressed: (){
                        },
                        child: Container(
                          height: dev_height / 8,
                          alignment: Alignment(0,0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Get Feedbacks !',style: TextStyle(
                                color: globals.MyGlobals.lightcolor,
                                fontSize: 30,
                                fontWeight: FontWeight.w100,
                              ),
                                textAlign: TextAlign.center,
                              ),
                              Divider(color: Colors.transparent,),
                              Text(
                                'View your feedback history !',style: TextStyle(
                                color: globals.MyGlobals.lightcolor,
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                              ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
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