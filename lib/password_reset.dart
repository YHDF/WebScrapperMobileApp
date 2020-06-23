import 'dart:convert';
import 'Globals.dart' as globals;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'device_dimensions.dart';
import 'message.dart';


class Reset extends StatefulWidget{
  ResetState createState() => ResetState();
}
class ResetState extends State<Reset>{
  double dev_width , dev_height ;
  final _controller = TextEditingController();
  void send_password() async{
    await Future<Message>(() async{
      final response = await http.post("${globals.MyGlobals.link_start}/api/sendpassword?email=${_controller.text}");
      if (response.statusCode == 200) {
        return Message.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Reset');
      }
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
                const Color.fromRGBO(134, 143, 150, 1),
                const Color.fromRGBO(89, 97, 100, 1),
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
                      Column(
                        children: <Widget>[
                          Divider(height: dev_height / 64,),
                          Container(
                            width: dev_width / 5,
                            height: dev_height / 16,
                            child: FlatButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Icon(
                                IconData(58820, fontFamily: 'MaterialIcons', matchTextDirection: true),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      VerticalDivider(width: dev_width / 128,color: Colors.transparent,),
                      Container(
                        alignment: Alignment(0,0),
                        width: 3 * dev_width / 4,
                        height: dev_height / 16,
                        decoration: BoxDecoration(
                          color: Colors.transparent ,
                          border: Border(bottom: BorderSide(color: Colors.white,width: 0.5)),
                        ),
                        child:Text(
                          "Enter your email address :",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w100,
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
                          width: dev_width / 1.3,
                          height: dev_height / 14.64,
                          alignment: Alignment(1, 1),
                          child: TextFormField(
                            controller: _controller,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Email is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 0.5,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 0.5
                                  ),
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  color: Colors.white,
                                  fontSize: dev_height > dev_width
                                      ? dev_height / 29.28
                                      : dev_height / 16.48,
                                )),
                          ),
                        ),
                      ),
                    ],
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
                      send_password();
                      _controller.text = '';
                      FocusScope.of(context).requestFocus(FocusNode());
                      //Navigator.pop(context);
                    },
                    child: Icon(
                        IconData(58826, fontFamily: 'MaterialIcons'),
                      size: 35,
                      color: Colors.white,
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

