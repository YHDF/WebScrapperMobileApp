import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pfe_mobile/background.dart';
import 'package:pfe_mobile/message.dart';
import'bottom_bar.dart';
import 'device_dimensions.dart';
import 'side.dart';
import 'Globals.dart' as globals;

class Create_Feedback extends StatefulWidget {
  Create_FeedbackState createState() => Create_FeedbackState();
}
class Create_FeedbackState extends State<Create_Feedback> with TickerProviderStateMixin{
  double dev_width, dev_height;
  static bool msgvisible = false;
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  static String confirm_message = '';

  @override
  void initState(){
    super.initState();
    msgvisible = false;
    confirm_message = '';
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
            Background(),
            Container(
              height: 0.9 * dev_height,
              child: ListView(
                children: <Widget>[
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
                                  'Topic Title:',
                                  style: TextStyle(
                                      color: globals.MyGlobals.lightcolor, fontSize: 20,fontWeight: FontWeight.w200,),
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
                  Divider(color: Colors.transparent,height: 25,),
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
                                color: globals.MyGlobals.lightcolor,
                                width: 0.5),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: globals.MyGlobals.lightcolor,
                                width: 0.5),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: '   ',
                        ),
                      ),
                    ),
                  ),
                  Divider(color: Colors.transparent,height: 25,),
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
                                  'Topic Subject:',
                                  style: TextStyle(
                                    color: globals.MyGlobals.lightcolor, fontSize: 20,fontWeight: FontWeight.w200,),
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
                  Divider(color: Colors.transparent,height: 25,),
                  Container(
                    alignment: Alignment(0,0),
                    child: Container(
                      height: dev_height / 2.5,
                      width: 0.9 * dev_width,
                      child: TextField(
                        controller: _controller2,
                        cursorColor: globals.MyGlobals.lightcolor,
                        decoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(vertical: dev_height / 2.5),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: globals.MyGlobals.lightcolor,
                                width: 0.5),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: globals.MyGlobals.lightcolor,
                                width: 0.5),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: '   ',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: dev_height / 6,
                    alignment: Alignment(0,1),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: dev_height / 10,
                          alignment: Alignment(0,0),
                          child: Visibility(
                            visible: msgvisible,
                            child: Text(confirm_message,
                              style: TextStyle(color: globals.MyGlobals.lightcolor,fontSize: 20,fontWeight: FontWeight.w200),
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
                                color: Colors.transparent,
                                border: Border.all(color: globals.MyGlobals.lightcolor,width: 0.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Submit',style: TextStyle(color: globals.MyGlobals.lightcolor,fontSize: 20,fontWeight: FontWeight.w200,),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            bottom_bar(),
          ],
        ),
        drawer: side_bar(),
      ),
    );
  }
}