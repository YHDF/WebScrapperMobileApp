import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pfe_mobile/message.dart';
import'bottom_bar.dart';
import 'device_dimensions.dart';
import 'side.dart';
import 'Globals.dart' as globals;

class client_reclamation extends StatefulWidget {
  client_reclamationState createState() => client_reclamationState();
}
class client_reclamationState extends State<client_reclamation> with TickerProviderStateMixin{
  double dev_width, dev_height;
  static bool msgvisible = false;
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  AnimationController opacity_animator;
  Animation<double> opacity_animation;
  double opacity = 0;
  static String confirm_message = '';

  @override
  void initState(){
    super.initState();
    msgvisible = false;
    confirm_message = '';
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
  @override
  void dispose(){
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void submit_feedback() async{
    if(_controller1.text == '' ||_controller2.text == ''){
      confirm_message = 'Subject and message are Required !';
    }else{
      await Future<Message>(() async {
        final response = await http.post('${globals.MyGlobals.link_start}/api/feedback?api_token=${globals.MyGlobals.api_token}&subject=${_controller1.text}&text=${_controller2.text}');
        if (response.statusCode == 200) {
          return Message.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to load Message');
        }
      }).then((value){
        setState(() {
          confirm_message = value.message;
          _controller1.text = '';
          _controller2.text = '';
        });
      });
    }

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
    setState(() {
      if(MediaQuery.of(context).viewInsets.bottom > 0){
        bottom_barState.visible = false;
      }else{
        bottom_barState.visible = true;
      }
    });
    dev_width = device_dimensions(context).dev_width;
    dev_height = device_dimensions(context).dev_height;
    return WillPopScope(
      onWillPop: _onpress,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            bottom_bar(),
            Container(
              height: 0.9 * dev_height,
              child: ListView(
                children: <Widget>[
                  Container(
                    height: dev_height / 12,
                    alignment: Alignment(0,0),
                    child: Text("What's on your mind ?",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w400,
                            color: globals.MyGlobals.lightcolor.withOpacity(opacity),
                            fontFamily: 'CoolFont'
                        )
                    ),
                  ),
                  Container(
                    height: dev_height / 8,
                    alignment: Alignment(0,0),
                    child: Text("We care About your feedback.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w400,
                            color: globals.MyGlobals.lightcolor.withOpacity(opacity),
                            fontFamily: 'CoolFont'
                        )
                    ),
                  ),
                  Container(
                    height: dev_height / 10,
                    alignment: Alignment(0,0),
                    child: Text("So help us improve.",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w400,
                            color: globals.MyGlobals.lightcolor.withOpacity(opacity),
                            fontFamily: 'CoolFont'
                        )
                    ),
                  ),
                  Container(
                    alignment: Alignment(0,-0.5),
                    child: Container(
                      height: dev_height / 24,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: dev_width / 3,
                            alignment: Alignment(0, 0.5),
                            child: Divider(
                              color: globals.MyGlobals.lightcolor,
                              indent: 5,
                              endIndent: 5,
                            ),
                          ),
                          Container(
                              width: dev_width / 3,
                              child: Center(
                                child: Text(
                                  'Your Feedback',
                                  style: TextStyle(
                                      color: globals.MyGlobals.lightcolor, fontSize: 20),
                                ),
                              )),
                          Container(
                            width: dev_width / 3,
                            alignment: Alignment(0, 0.5),
                            child: Divider(
                              color: globals.MyGlobals.lightcolor,
                              indent: 5,
                              endIndent: 5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width : dev_width / 4,
                        alignment: Alignment(1,0),
                        child: Text('Topic title: ',
                          style: TextStyle(
                            fontSize: 20,
                            color: globals.MyGlobals.lightcolor,
                          ),
                        ),
                      ),
                      //VerticalDivider(color: Colors.transparent, width: 75,),
                      Container(
                        alignment: Alignment(0,0),
                        child: Container(
                          height: dev_height / 18,
                          width: 2 * dev_width / 3,
                          child: TextField(
                            controller: _controller1,
                            cursorColor: globals.MyGlobals.lightcolor,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: globals.MyGlobals.lightcolor.withOpacity(0.3),
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: globals.MyGlobals.lightcolor.withOpacity(0.3),
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              labelText: '   ',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.transparent,height: 25,),
                  Row(
                    children: <Widget>[
                      Container(
                        height: dev_height / 10,
                        width : dev_width / 4,
                        alignment: Alignment(1,0),
                        child: Text('Message : ',
                          style: TextStyle(
                            fontSize: 20,
                            color: globals.MyGlobals.lightcolor,
                          ),
                        ),
                      ),
                      //VerticalDivider(color: Colors.transparent, width: 75,),
                      Container(
                        alignment: Alignment(0,0),
                        child: Container(
                          height: dev_height / 4,
                          width: 2* dev_width / 3,
                          child: TextField(
                            controller: _controller2,
                            cursorColor: globals.MyGlobals.lightcolor,
                            decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(vertical: dev_height / 8, horizontal: 10.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: globals.MyGlobals.lightcolor.withOpacity(0.3),
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: globals.MyGlobals.lightcolor.withOpacity(0.3),
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              labelText: '   ',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: dev_height / 6,
                    alignment: Alignment(0,1),
                    child: Container(
                      height: dev_height / 16,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 2 * dev_width / 3,
                            child: Visibility(
                              visible: msgvisible,
                              child: Text(confirm_message,
                                style: TextStyle(color: globals.MyGlobals.lightcolor,fontSize: 20),
                              ),
                            ),
                          ),
                          Container(
                            width: dev_width / 3,
                            alignment: Alignment(1,1),
                            child: FlatButton(
                              onPressed: (){
                                setState(() {
                                  submit_feedback();
                                  msgvisible = true;
                                });
                              },
                              child: Container(
                                alignment: Alignment(0,0),
                                width: dev_width / 3,
                                height: dev_height / 16,
                                decoration: BoxDecoration(
                                  color: globals.MyGlobals.lightcolor.withOpacity(0.5),
                                  border: Border.all(color: Colors.transparent,width: 0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text('Submit',style: TextStyle(color: globals.MyGlobals.lightcolor,fontSize: 20),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        drawer: side_bar(),
      ),
    );
  }
}