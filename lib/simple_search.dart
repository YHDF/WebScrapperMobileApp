import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pfe_mobile/background.dart';
import 'package:pfe_mobile/bottom_bar.dart';
import 'package:pfe_mobile/custom_search.dart';
import 'package:pfe_mobile/device_dimensions.dart';
import 'package:pfe_mobile/product_detail.dart';
import 'package:pfe_mobile/searchresult.dart';
import 'Globals.dart' as globals;

class Simple_Search extends StatefulWidget{
  Simple_SearchState createState() => Simple_SearchState();

}
class Simple_SearchState extends State<Simple_Search> with TickerProviderStateMixin{
  Color selectedColor = globals.MyGlobals.darkcolor;
  List<String> stringtest = new List<String>();
  List<String> stringresult = new List<String>();
  static int j = 0;
  TextEditingController ctrl = new TextEditingController();
  FocusNode _focus = new FocusNode();
  static bool isresultvisible;
  static int product_index = 0;
  double dev_height, dev_width;
  AnimationController alignment_controller;
  Animation<double> alignment_animation;
  double alignment_value = 0;
  static bool btn_visible = true;


  void initState(){
    super.initState();
    alignment_controller =AnimationController(vsync: this, duration: Duration(seconds: 1));
    alignment_animation = Tween<double>( begin: -1.5, end: 1).animate(CurvedAnimation(
        parent: alignment_controller,curve: Interval(0.25, 1, curve: Curves.elasticInOut)));
    alignment_controller.addListener(() {
      setState(() {
        alignment_value = alignment_animation.value;
      });
    });
    alignment_controller.forward();
    ctrl.addListener(textchanged);
    isresultvisible = false;
    for (int i = 0; i < globals.MyGlobals.all_products.length; i++) {
      stringresult.insert(i, '');
    }
  }
  void dispose(){
    alignment_controller.dispose();
    ctrl.dispose();
    super.dispose();
  }
  void textchanged() {
    //if (!mounted) return;
    setState(() {
      stringresult.clear();
      for (int i = 0; i < globals.MyGlobals.all_products.length; i++) {
        stringresult.insert(i, '');
      }
      /*if (ctrl.text == '') {
        isresultvisible = false;
      } else {
        isresultvisible = true;
      }*/
      for (int i = 0; i < stringresult.length; i++) {
        if (globals.MyGlobals.all_products[i].name.contains(ctrl.text) &&
            ctrl.text != '') {
          stringresult[j++] = globals.MyGlobals.all_products[i].name;
        }
      }
      j = 0;
    });
  }
  void Simple_filter(){
    List<int> count = List<int>();
    for (int i = 0; i < globals.MyGlobals.search_result.length; i++) {
      if (!globals.MyGlobals.search_result[i].name.contains(ctrl.text)) {
        count.add(i);
      }
    }
    count.sort();
    for (int i = count.length - 1; i >= 0; i--) {
      globals.MyGlobals.search_result.removeAt(count[i]);
    }
    count.clear();
  }

  @override
  Widget build(BuildContext context) {
    dev_width = device_dimensions(context).dev_width;
    dev_height = device_dimensions(context).dev_height;
    return Stack(
          children: <Widget>[
            Background(),
            Container(
              width: dev_width,
              height: dev_height * 0.9,
              child: new Column(
                children: <Widget>[
                  Visibility(
                    visible: btn_visible,
                    child: Container(
                      height: dev_height / 3,
                      alignment: Alignment(0,alignment_value),
                      child: Text(
                        'Search :',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w100,
                          color: globals.MyGlobals.lightcolor,
                        ),
                      ),
                    ),
                  ),
                  Divider(height: dev_height / 16,color: Colors.transparent,),
                  Container(
                    height: dev_height / 12,
                    child: Container(
                      width: dev_width * 0.8,
                      child: TextField(
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.w100),
                        focusNode: _focus,
                        controller: ctrl,
                        cursorColor: globals.MyGlobals.lightcolor,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: globals.MyGlobals.lightcolor,
                                width: 0.5),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: globals.MyGlobals.lightcolor,
                                width: 0.5),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          labelText: '   ',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment(0,-0.2),
                    child: Visibility(
                      visible: isresultvisible,
                      child: Container(
                        height: dev_height / 8,
                        alignment: Alignment(0, -1),
                        child: Container(
                          height: 100,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: stringresult.length > 10 ? 10 : stringresult.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Visibility(
                                visible: stringresult[index] != "" ? true : false,
                                child: Container(
                                  alignment: Alignment(0, 0),
                                  child: Container(
                                    margin: EdgeInsets.all(15),
                                    width: 150,
                                    height: 75,
                                    decoration: BoxDecoration(
                                      color: globals.MyGlobals.lightcolor
                                          .withOpacity(0),
                                      border: Border.all(
                                        color: globals.MyGlobals.lightcolor,
                                        width: 0.3,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: FlatButton(
                                      onPressed: () {
                                        setState(() {
                                          for (int i = 0;
                                          i <
                                              globals.MyGlobals
                                                  .all_products.length;
                                          i++) {
                                            if (globals.MyGlobals
                                                .all_products[i].name ==
                                                stringresult[index]) {
                                              product_index = i;
                                              break;
                                            }
                                          }
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    product_detail(
                                                        product_index)),
                                          );
                                        });
                                      },
                                      child: Center(
                                          child: Text(
                                            '${stringresult[index]}',
                                            //overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w200,
                                                color:
                                                globals.MyGlobals.lightcolor),
                                          )),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                            const Divider(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: dev_height / 12,
                    width: dev_width / 2,
                    alignment: Alignment(0,1),
                    child: FlatButton(
                      onPressed: (){
                        setState(() {
                          Custom_SearchState.Custom_filter();
                          Simple_filter();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Searchresult()),
                          );
                        });
                      },
                      child: Container(
                        height: dev_height / 16,
                        width: dev_width / 3,
                        alignment: Alignment(0,0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: globals.MyGlobals.lightcolor.withOpacity(0.5),width: 0.7),
                          color: globals.MyGlobals.lightcolor.withOpacity(0),
                        ),
                        child: Text('search',style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 20,
                          color: globals.MyGlobals.lightcolor,
                        ),),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: btn_visible,
                    child: Container(
                      width: dev_width / 2.06,
                      height: dev_height / 3,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment(
                                0, 0.7),
                            child: Text(
                              'More options',
                              style: TextStyle(
                                  color: globals.MyGlobals.lightcolor,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 20,
                              ),
                            )
                          ),
                          Container(
                            alignment:
                            Alignment(0, 1),
                            child: Icon(
                              IconData(58831, fontFamily: 'MaterialIcons'),
                              size: dev_height > dev_width
                                  ? dev_width / 14.3
                                  : dev_height / 14.3,
                              color: globals.MyGlobals.lightcolor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottom_bar(),
          ],

    );
  }

}