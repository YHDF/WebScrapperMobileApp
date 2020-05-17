import 'dart:convert';
import 'package:pfe_mobile/message.dart';
import 'package:pfe_mobile/password_reset.dart';
import 'package:pfe_mobile/session_token.dart';
import 'package:pfe_mobile/verify_register.dart';
import 'Globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:pfe_mobile/device_dimensions.dart';
import 'package:pfe_mobile/home.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_mobile/register.dart';
import 'login.dart';
import 'setting_variables.dart';

class auth_dynamic extends StatefulWidget {
  @override
  _auth_dynamicState createState() => _auth_dynamicState();
}

class _auth_dynamicState extends State<auth_dynamic> {
  double dev_width, dev_height;
  bool forgot_password_visible = true;


  var isLogin = true;
  var isSignup = false;
  static bool istopbarvisible = true;

  Widget build(BuildContext context) {
    setState(() {
      if (MediaQuery.of(context).viewInsets.bottom > 0) {
        forgot_password_visible = false;
        istopbarvisible = false;
      } else {
        forgot_password_visible = true;
        istopbarvisible = true;
      }
    });
    double dev_width = device_dimensions(context).dev_width;
    double dev_height = device_dimensions(context).dev_height;
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
                alignment: Alignment(0, -0.8),
                child: Visibility(
                  visible: istopbarvisible,
                  child: Container(
                    width: dev_width / 1.37,
                    height: dev_height / 18.3,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          border: Border.all(
                            width: 0,
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(
                              dev_height > dev_width
                                  ? dev_height / 18.3
                                  : dev_height / 10.3)),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: dev_width / 2.75,
                            alignment: Alignment(-1, 0),
                            child: FlatButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                setState(() {
                                  isSignup = false;
                                  isLogin = true;
                                });
                              },
                              child: Container(
                                alignment: Alignment(0, 0),
                                child: Text(
                                  'Existing',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: isLogin == true
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: dev_width / 2.75,
                            child: FlatButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                setState(() {
                                  isLogin = false;
                                  isSignup = true;
                                });
                              },
                              child: Container(
                                alignment: Alignment(0, 0),
                                child: Text(
                                  'New',
                                  style: TextStyle(
                                    fontSize: dev_height > dev_width
                                        ? dev_height / 29.28
                                        : dev_height / 16.48,
                                    color: isSignup == true
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.5),
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
              ),
              Container(
                alignment: Alignment(0, isLogin ? -0.35 : 0.5),
                child: isLogin ? Login_Container() : Signup_Container(),
              ),
              Visibility(
                visible: isLogin && forgot_password_visible,
                child: Container(
                  alignment: Alignment(0, 0.9),
                  child: Container(
                    width: 3 * dev_width / 4,
                    height: dev_height / 18,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Reset()),
                          );
                        },
                        child: Text(
                          'forgot your password ?',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ),
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

class Login_Container extends StatefulWidget {
  @override
  Login_ContainerState createState() {
    return Login_ContainerState();
  }
}

class Login_ContainerState extends State<Login_Container> {
  static String email = '';
  static String password = '';
  static final _formKey = GlobalKey<FormState>();
  FocusScopeNode _focusScopeNode = FocusScopeNode();
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  static String verification_message = '';
  static bool correct_credentials = true;

  void dispose() {
    _focusScopeNode.dispose();
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void submit(BuildContext context) async {
    await Future<dynamic>(() async {
      final response = await http.post(
          "${globals.MyGlobals.link_start}/api/login?email=$email&password=$password");
      if (response.statusCode == 200) {
        var logs = Login.fromJson(json.decode(response.body));
        if(logs.name == null || logs.email == null ||logs.token == null){
          correct_credentials = false;
          return Message.fromJson(json.decode(response.body));
        }
        return logs;
      } else {
        throw Exception('Failed to load Login');
      }
    }).then((value) async {
      if(!correct_credentials){
        setState(() {
          verification_message = value.message;
          correct_credentials = true;
        });
      }else{
        globals.MyGlobals.api_token = value.token;
        await session_token.defaultSessionWriter();
        await setting_variables.defaultConfigWriter().then((value) {
          Future<setting_variables>(() {
            return setting_variables.configReader();
          }).then((value) {
            if (value.lightmode == true && value.darkmode == false) {
              globals.MyGlobals.lightcolor = Colors.white;
              globals.MyGlobals.darkcolor = Colors.black;
            }
            if (value.lightmode == false && value.darkmode == true) {
              globals.MyGlobals.lightcolor = Colors.black;
              globals.MyGlobals.darkcolor = Colors.white;
            }
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          });
        });
      }
    });
  }

  void _handleSubmitted(String value) {
    _focusScopeNode.nextFocus();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if(_controller1.text == '' && _controller2.text == ''){
        verification_message = '';
      }
    });
    double dev_width = device_dimensions(context).dev_width;
    double dev_height = device_dimensions(context).dev_height;
    return Container(
      width: dev_width / 1.18,
      height: dev_height / 2,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: 0,
        ),
        borderRadius: BorderRadius.circular(
            dev_height > dev_width ? dev_height / 73.2 : dev_height / 41.2),
        color: Colors.white.withOpacity(0.5),
      ),
      child: Form(
        key: _formKey,
        child: FocusScope(
          node: _focusScopeNode,
          child: Column(
            children: <Widget>[
              Container(
                height: dev_height / 18,
                alignment: Alignment(0,0),
                child: Text(
                  verification_message,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                height: dev_height / 7.32,
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment(-1, 1),
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
                      alignment: Alignment(1, 1),
                      child: Container(
                        width: dev_width / 1.5,
                        height: dev_height / 14.64,
                        alignment: Alignment(1, 1),
                        child: TextFormField(
                          onTap: () {},
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: _handleSubmitted,
                          controller: _controller1,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Email is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email Address',
                              hintStyle: TextStyle(
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
              Container(
                height: dev_height / 7.32,
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment(-1, 1),
                      child: Container(
                        width: dev_width / 5.70,
                        height: dev_height / 14.64,
                        alignment: Alignment(0, 0.2),
                        child: Icon(
                          IconData(59545, fontFamily: 'MaterialIcons'),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment(1, 1),
                      child: Container(
                        width: dev_width / 1.5,
                        height: dev_height / 14.64,
                        alignment: Alignment(1, 1),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.previous,
                          onFieldSubmitted: _handleSubmitted,
                          controller: _controller2,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                              hintStyle: TextStyle(
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
              Container(
                height: dev_height / 6,
                alignment: Alignment(0, 1),
                child: Container(
                  height: dev_height / 73.2,
                  child: OverflowBox(
                    maxWidth: dev_width,
                    maxHeight: dev_height / 5,
                    child: FlatButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          email = _controller1.text;
                          password = _controller2.text;
                          submit(context);
                        }
                      },
                      child: Container(
                        width: dev_width / 1.648,
                        height: dev_height / 14,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.transparent,
                            width: 0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment(-1, -1),
                            end: Alignment(1, 1),
                            colors: [
                              const Color.fromRGBO(255, 155, 112, 1),
                              const Color.fromRGBO(255, 75, 112, 1)
                            ], // whitish to gray
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: dev_height > dev_width
                                  ? dev_height / 24.4
                                  : dev_height / 13.74,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Signup_Container extends StatefulWidget {
  @override
  Signup_ContainerState createState() => Signup_ContainerState();
}

class Signup_ContainerState extends State<Signup_Container> {
  static double dev_width, dev_height;
  static String email = '';
  static String password = '';
  static String name = '';
  static final _formKey = GlobalKey<FormState>();
  FocusScopeNode _focusScopeNode = FocusScopeNode();
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();

  void submit(BuildContext context) async {
    await Future<dynamic>(() async {
      final response = await http.post(
          "${globals.MyGlobals.link_start}/api/register?name=$name&email=$email&password=$password&password_confirmation=$password");
      if (response.statusCode == 200) {
        return Register.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Register');
      }
    }).then((value) async {
      await Future<dynamic>(() async {
        globals.MyGlobals.api_token = value.token;
        final response = await http.get(
            "${globals.MyGlobals.link_start}/api/sendverify?api_token=${value.token}");
        if (response.statusCode == 200) {
          return Message.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to load verify');
        }
      }).then((value) => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Verify()),
          ));
    });
  }

  void dispose() {
    _focusScopeNode.dispose();
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  void _handleSubmitted(String value) {
    _focusScopeNode.nextFocus();
  }

  @override
  Widget build(BuildContext context) {
    dev_width = device_dimensions(context).dev_width;
    dev_height = device_dimensions(context).dev_height;
    // TODO: implement build
    return Container(
      width: 0.9 * dev_width,
      height: dev_height / 1.8,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: 0,
        ),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.5),
      ),
      child: Form(
        key: _formKey,
        child: FocusScope(
          node: _focusScopeNode,
          child: Column(
            children: <Widget>[
              Container(
                height: dev_height / 7.32,
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment(-1, 1),
                      child: Container(
                        width: dev_width / 7,
                        height: dev_height / 14.62,
                        alignment: Alignment(0, 0.2),
                        child: Icon(
                          IconData(59516, fontFamily: 'MaterialIcons'),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment(1, 1),
                      child: Container(
                        width: dev_width / 1.5,
                        height: dev_height / 14.62,
                        alignment: Alignment(1, 1),
                        child: TextFormField(
                          onTap: () {
                            _auth_dynamicState.istopbarvisible = false;
                            auth_dynamic();
                          },
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: _handleSubmitted,
                          controller: _controller1,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Full  Name',
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: dev_height > dev_width
                                      ? dev_height / 29.28
                                      : dev_height / 16.48)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: dev_height / 7.32,
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment(-1, 1),
                      child: Container(
                        width: dev_width / 7,
                        height: dev_height / 14.62,
                        alignment: Alignment(0, 0.2),
                        child: Icon(
                          IconData(57534, fontFamily: 'MaterialIcons'),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment(1, 1),
                      child: Container(
                        width: dev_width / 1.5,
                        height: dev_height / 14.62,
                        alignment: Alignment(1, 1),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: _handleSubmitted,
                          controller: _controller2,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email Address',
                              hintStyle: TextStyle(
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
              Container(
                height: dev_height / 7.32,
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment(-1, 1),
                      child: Container(
                        width: dev_width / 7,
                        height: dev_height / 14.62,
                        alignment: Alignment(0, 0.2),
                        child: Icon(
                          IconData(59545, fontFamily: 'MaterialIcons'),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment(1, 1),
                      child: Container(
                        width: dev_width / 1.5,
                        height: dev_height / 14.62,
                        alignment: Alignment(1, 1),
                        child: TextFormField(
                          controller: _controller3,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.previous,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                              hintStyle: TextStyle(
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
              Container(
                height: dev_height / 7.32,
                alignment: Alignment(0, 1),
                child: Container(
                  height: dev_height / 29.28,
                  child: OverflowBox(
                    maxWidth: dev_width / 1.648,
                    maxHeight: dev_height / 7,
                    child: FlatButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          name = _controller1.text;
                          email = _controller2.text;
                          password = _controller3.text;
                          submit(context);
                        }
                      },
                      child: Container(
                        width: dev_width / 1.648,
                        height: dev_height / 14.64,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.transparent,
                            width: 0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment(-1, -1),
                            end: Alignment(1, 1),
                            colors: [
                              const Color.fromRGBO(255, 74, 105, 1),
                              const Color.fromRGBO(255, 155, 112, 1),
                            ], // whitish to gray
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: dev_width < dev_height
                                  ? dev_width / 13.73
                                  : dev_height / 24.4,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
