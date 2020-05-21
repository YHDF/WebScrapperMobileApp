import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pfe_mobile/background.dart';
import 'package:pfe_mobile/device_dimensions.dart';
import 'package:pfe_mobile/home.dart';
import 'package:pfe_mobile/message.dart';
import 'bottom_bar.dart';
import 'side.dart';
import 'Globals.dart' as globals;

class user_profile extends StatefulWidget {
  user_profileState createState() => user_profileState();
}

class user_profileState extends State<user_profile>
    with TickerProviderStateMixin {
  double dev_width, dev_height;
  AnimationController opacity_controller;
  Animation<double> opacity_anim;
  static double opacity = 0;
  final _controller = TextEditingController();
  static bool editable = false;
  bool hidden = true;
  String str;

  @override
  void initState() {
    setState(() {
      super.initState();
      str = '';
      opacity_controller =
          AnimationController(vsync: this, duration: Duration(seconds: 2));
      opacity_anim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: opacity_controller,
        curve: Interval(0.5, 1, curve: Curves.linear),
      ));
      opacity_controller.addListener(() {
        setState(() {
          opacity = opacity_anim.value;
        });
      });
      opacity_controller.forward();
    });
  }

  void change_name() async {
    await Future<Message>(() async {
      final response = await http.put(
          '${globals.MyGlobals.link_start}/api/user?api_token=${globals.MyGlobals.api_token}&name=${globals.MyGlobals.current_user.name}');
      if (response.statusCode == 200) {
        return Message.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Profile');
      }
    }).then((value) {
      setState(() {
        hidden = false;
        str = 'Click the button down below to confirm changes!';
      });
    });
  }

  @override
  void dispose() {
    opacity_controller.dispose();
    super.dispose();
  }

  Future<bool> _onpress() async {
    setState(() {
      bottom_barState.page_counter = 1;
      side_barState.lst_selected_side[0] = false;
      Navigator.pop(context);
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (MediaQuery.of(context).viewInsets.bottom > 0) {
        bottom_barState.visible = false;
      } else {
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
            GestureDetector(
              child: Container(
                width: dev_width,
                height: dev_height,
                alignment: Alignment(0, 0),
                child: Container(
                  width: dev_width,
                  height: 7 * dev_height / 8,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        alignment: Alignment(0, 0),
                        child: Text(
                          ' HELLO, ',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w200,
                            color: globals.MyGlobals.darkcolor,
                          ),
                        ),
                      ),
                      Divider(),
                      new editablecontainer(
                          globals.MyGlobals.current_user.name),
                      Visibility(
                        visible: editable,
                        child: Container(
                          width: dev_width,
                          height: dev_height / 6,
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 2 * dev_width / 3,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: globals.MyGlobals.lightcolor,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextFormField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: globals.MyGlobals.lightcolor,
                                      fontSize: dev_height > dev_width
                                          ? dev_height / 29.28
                                          : dev_height / 16.48,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: dev_height / 32,
                              ),
                              Container(
                                height: dev_height / 18,
                                child: FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      editable = false;
                                      globals.MyGlobals.current_user.name =
                                          _controller.text;
                                      change_name();
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment(0, 0),
                                    width: dev_width / 3,
                                    decoration: BoxDecoration(
                                      color: globals.MyGlobals.darkcolor,
                                      border: Border.all(color: globals.MyGlobals.darkcolor),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(
                                        color: globals.MyGlobals.lightcolor,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      Container(
                        alignment: Alignment(0, 0),
                        child: Text(
                          ' YOU HAVE, ',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w200,
                            color: globals.MyGlobals.darkcolor,
                          ),
                        ),
                      ),
                      Divider(),
                      viewable_container(
                          globals.MyGlobals.favorite_count.toString(),
                          IconData(59517, fontFamily: 'MaterialIcons')),
                      Divider(),
                      viewable_container(
                          globals.MyGlobals.feedback_count.toString(),
                          IconData(57534, fontFamily: 'MaterialIcons',),),
                      Divider(),
                      Container(
                        alignment: Alignment(0, 0),
                        child: Text(
                          'WITH EMAIL',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w200,
                            color: globals.MyGlobals.darkcolor,
                          ),
                        ),
                      ),
                      Divider(),
                      viewable_container(
                          globals.MyGlobals.current_user.email, null),
                      Container(
                        height: dev_height / 12,
                        child: Visibility(
                          visible: !hidden,
                          child: Container(
                            alignment: Alignment(0, 1),
                            child: Text(
                              str,
                              style: TextStyle(
                                color: globals.MyGlobals.lightcolor,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: dev_height / 12,
                        color: Colors.transparent,
                      ),
                      Container(
                        height: dev_height / 12,
                        alignment: Alignment(0, 1),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          },
                          child: Container(
                            width: dev_height / 16,
                            height: dev_height / 16,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.transparent, width: 0),
                              borderRadius: BorderRadius.circular(50),
                              color: globals.MyGlobals.lightcolor,
                            ),
                            child: Center(
                              child: Icon(
                                IconData(58139, fontFamily: 'MaterialIcons'),
                                color: globals.MyGlobals.darkcolor,
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
            bottom_bar(),
          ],
        ),
        drawer: side_bar(),
      ),
    );
  }
}

class editablecontainer extends StatefulWidget {
  String data;

  editablecontainer(String data) {
    this.data = data;
  }

  editablecontainerState createState() => editablecontainerState(data);
}

class editablecontainerState extends State<editablecontainer> {
  String data;

  editablecontainerState(String data) {
    this.data = data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: device_dimensions(context).dev_width,
        height: device_dimensions(context).dev_height / 16,
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment(0, 0),
              child: FlatButton(
                onPressed: () {},
                child: Container(
                  width: 7 * device_dimensions(context).dev_width / 8,
                  alignment: Alignment(0, 0),
                  child: Text(
                    data,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: globals.MyGlobals.lightcolor
                          .withOpacity(user_profileState.opacity),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: device_dimensions(context).dev_width,
              alignment: Alignment(1, 0),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    user_profileState.editable =
                        user_profileState.editable ? false : true;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => user_profile()),
                    );
                  });
                },
                child: Container(
                  width: device_dimensions(context).dev_width / 8,
                  child: Icon(
                    IconData(57680, fontFamily: 'MaterialIcons'),
                    color: globals.MyGlobals.lightcolor
                        .withOpacity(user_profileState.opacity),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class viewable_container extends StatefulWidget {
  String data;
  IconData icon_data;

  viewable_container(String data, IconData icon_data) {
    this.data = data;
    this.icon_data = icon_data;
  }

  viewable_containerState createState() =>
      viewable_containerState(data, icon_data);
}

class viewable_containerState extends State<viewable_container> {
  String data;
  IconData icondata;

  viewable_containerState(String data, IconData icondata) {
    this.data = data;
    this.icondata = icondata;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: device_dimensions(context).dev_width,
        height: device_dimensions(context).dev_height / 16,
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment(0, 0),
              child: Container(
                  width: 7 * device_dimensions(context).dev_width / 8,
                  alignment: Alignment(0, 0),
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: 7 * device_dimensions(context).dev_width / 8,
                          alignment: Alignment(-0.1, 0),
                          child: Text(
                            data,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: globals.MyGlobals.lightcolor
                                  .withOpacity(user_profileState.opacity),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          width: 7 * device_dimensions(context).dev_width / 8,
                          alignment: Alignment(0.1, 0),
                          child: Icon(
                            icondata,
                            color: globals.MyGlobals.lightcolor
                                .withOpacity(user_profileState.opacity),
                            size: 25,
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            Container(
              width: device_dimensions(context).dev_width,
              alignment: Alignment(1, 0),
              child: Container(
                width: device_dimensions(context).dev_width / 8,
                child: FlatButton(
                  onPressed: () {},
                  child: Container(
                    width: device_dimensions(context).dev_width / 8,
                    child: Icon(
                      IconData(58391, fontFamily: 'MaterialIcons'),
                      color: globals.MyGlobals.lightcolor
                          .withOpacity(user_profileState.opacity),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
