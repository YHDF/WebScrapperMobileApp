import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_mobile/session_token.dart';
import 'Globals.dart' as globals;
import 'device_dimensions.dart';
import 'home.dart';
import 'message.dart';
import 'setting_variables.dart';


class Verify extends StatefulWidget{
  VerifyState createState() => VerifyState();
}
class VerifyState extends State<Verify>{
  double dev_width , dev_height ;
  final _controller = TextEditingController();
  void verify_code() async{
    await Future<Message>(() async{
      final response = await http.post("${globals.MyGlobals.link_start}/api/verify?api_token=${globals.MyGlobals.api_token}&code=${_controller.text}");
      if (response.statusCode == 200) {
        return Message.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Verify');
      }
    }).then((value) async{
      await session_token.defaultSessionWriter();
      await setting_variables.defaultConfigWriter();
      Future<setting_variables>((){
        return setting_variables.configReader();
      }).then((value) {
        if(value.lightmode == true && value.darkmode == false){
          globals.MyGlobals.lightcolor = Colors.white;
          globals.MyGlobals.darkcolor = Colors.black;
        }
        if(value.lightmode == false && value.darkmode == true){
          globals.MyGlobals.lightcolor = Colors.black;
          globals.MyGlobals.darkcolor = Colors.white;
        }
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    double dev_width = device_dimensions(context).dev_width;
    double dev_height =  device_dimensions(context).dev_height;
    return Scaffold(
      body: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1, -1),
              end: Alignment(-1, 1),
              colors: [
                const Color.fromRGBO(255, 155, 112, 1),
                const Color.fromRGBO(255, 74, 105, 1),
              ], // whitish to gray
            ),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment(0,-0.6),
                child: Container(
                  height: dev_height / 12,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: dev_width / 5,
                        height: dev_height / 10,
                        child: FlatButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: dev_width < dev_height ?  dev_width / 10 :  dev_height / 10,
                            height: dev_width < dev_height ? dev_width / 10 :  dev_height / 10,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              border: Border.all(color: Colors.transparent,width: 0.0),
                              borderRadius: BorderRadius.circular(dev_width),
                            ),
                            child: Icon(
                              IconData(58820, fontFamily: 'MaterialIcons', matchTextDirection: true),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      VerticalDivider(width: dev_width / 32,),
                      Container(
                        alignment: Alignment(0,0),
                        width: 2 * dev_width / 3,
                        height: dev_height / 16,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.transparent, width: 0.0),
                        ),
                        child:Text(
                          "A verification code has been sent to your email.",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment(0,0.2),
                child: Container(
                  width: 0.9 * dev_width,
                  height: dev_height / 10,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    border: Border.all(color: Colors.transparent, width: 0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Container(
                      height: dev_height / 8,
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment(-1, 0),
                            child: Container(
                              width: dev_width / 5.70,
                              height: dev_height / 14.64,
                              alignment: Alignment(0, 0.2),
                              child: Icon(
                                IconData(57534, fontFamily: 'MaterialIcons'),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment(1, 0),
                            child: Container(
                              width: dev_width / 1.5,
                              height: dev_height / 14.64,
                              alignment: Alignment(1, 1),
                              child: TextFormField(
                                controller: _controller,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Verification Code is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Verification Code',
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: dev_height > dev_width ? dev_height/ 29.28 : dev_height / 16.48,
                                    )
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
                alignment: Alignment(0,1),
                child: Container(
                  width: 0.25 * dev_width,
                  height: 0.1 * dev_height,
                  child: FlatButton(
                    onPressed: (){
                      _controller.text = '';
                      FocusScope.of(context).requestFocus(FocusNode());
                      verify_code();
                      //Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment(0,0),
                      width: dev_width < dev_height ? 0.15 * dev_width : 0.15 * dev_height,
                      height: dev_width < dev_height ? 0.15 * dev_width : 0.15 * dev_height,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        border: Border.all(color: Colors.transparent,width: 0.0),
                        borderRadius: BorderRadius.circular(dev_width),
                      ),
                      child: Icon(
                        IconData(58826, fontFamily: 'MaterialIcons'),
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
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

