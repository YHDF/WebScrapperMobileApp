import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe_mobile/background.dart';
import 'package:pfe_mobile/bottom_bar.dart';
import 'package:pfe_mobile/device_dimensions.dart';
import 'package:pfe_mobile/home.dart';
import 'package:pfe_mobile/product_detail.dart';
import 'package:pfe_mobile/side.dart';
import 'side.dart';
import 'Globals.dart' as globals;

class search extends StatefulWidget {
  @override
  searchState createState() => searchState();
}

class searchState extends State<search> {
  Color selectedColor = globals.MyGlobals.darkcolor;
  static String textvalue = '';
  static double dev_width,
      dev_height,
      amazon_width,
      ebay_width,
      walmart_width,
      jumia_width,
      amazon_height,
      ebay_height,
      walmart_height,
      jumia_height;
  static bool isamazon, isebay, iswalmart, isjumia;
  static Color amazon_color, ebay_color, walmart_color, jumia_color;
  static final AssetImage checked_img = AssetImage('assets/images/check.png');
  static final AssetImage unchecked_img = AssetImage('assets/images/close.png');
  static AssetImage amazon_cheched_img,
      ebay_checked_img,
      walmart_checked_img,
      jumia_checked_img;
  List<String> stringtest = new List<String>();
  List<String> stringresult = new List<String>();
  static int j = 0;
  final ctrl = TextEditingController();
  final min_price_ctrl = TextEditingController();
  final max_price_ctrl = TextEditingController();
  FocusNode _focus = new FocusNode();
  FocusNode _maxpricefocus = new FocusNode();
  FocusNode _minpricefocus = new FocusNode();
  static bool focused, isresultvisible;
  static Color computer_color, phone_color;
  static bool computer_selected, phone_selected, phone_rotated;
  static String prv_name = '';
  final scroll_it = new GlobalKey();
  static int product_index = 0;
  static bool ticked = false;

  void initState() {
    super.initState();
    isamazon = isebay = iswalmart = isjumia = true;
    amazon_color = ebay_color = walmart_color =
        jumia_color = globals.MyGlobals.lightcolor.withOpacity(0.3);
    amazon_cheched_img = ebay_checked_img =
        walmart_checked_img = jumia_checked_img = checked_img;
    ctrl.addListener(textchanged);
    _focus.addListener(_onfocuschange);
    max_price_ctrl.addListener(pricechanged);
    min_price_ctrl.addListener(pricechanged);
    _maxpricefocus.addListener(_onfocuschange);
    _minpricefocus.addListener(_onfocuschange);
    focused = isresultvisible = false;
    computer_selected = phone_selected = true;
    computer_color = phone_color = globals.MyGlobals.darkcolor;
    phone_rotated = false;
    for (int i = 0; i < globals.MyGlobals.all_products.length; i++) {
      stringresult.insert(i, '');
    }
  }

  void _onfocuschange() {
    setState(() {
      if (!focused) {
        bottom_barState.visible = false;
        focused = true;
      } else {
        bottom_barState.visible = true;
        focused = false;
        isresultvisible = false;
      }
    });
  }

  @override
  void dispose() {
    ctrl.dispose();
    _focus.dispose();
    _maxpricefocus.dispose();
    _minpricefocus.dispose();
    super.dispose();
  }

  Future<bool> _onpress() async {
    setState(() {
      bottom_barState.page_counter = 1;
      if (!bottom_barState.bottomsearchclicked) {
        side_barState.lst_selected_side[1] = false;
      }
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    });
    return true;
  }

  void search_filter() {
    globals.MyGlobals.search_result.clear();
    globals.MyGlobals.all_products.forEach((element) {
      globals.MyGlobals.search_result.add(element);
    });
    List<int> count = List<int>();
    if (!isjumia) {
      for (int i = 0; i < globals.MyGlobals.search_result.length; i++) {
        if (globals.MyGlobals.search_result[i].group_id == 9 ||
            globals.MyGlobals.search_result[i].group_id == 15) {
          count.add(i);
        }
      }
    }
    if (!isamazon) {
      for (int i = 0; i < globals.MyGlobals.search_result.length; i++) {
        if (globals.MyGlobals.search_result[i].group_id == 7 ||
            globals.MyGlobals.search_result[i].group_id == 11) {
          count.add(i);
        }
      }
    }
    if (!isebay) {
      for (int i = 0; i < globals.MyGlobals.search_result.length; i++) {
        if (globals.MyGlobals.search_result[i].group_id == 8 ||
            globals.MyGlobals.search_result[i].group_id == 12 ||
            globals.MyGlobals.search_result[i].group_id == 13) {
          count.add(i);
        }
      }
    }
    if (!iswalmart) {
      for (int i = 0; i < globals.MyGlobals.search_result.length; i++) {
        if (globals.MyGlobals.search_result[i].group_id == 10 ||
            globals.MyGlobals.search_result[i].group_id == 14) {
          count.add(i);
        }
      }
    }
    count.sort();
    for (int i = count.length - 1; i >= 0; i--) {
      globals.MyGlobals.search_result.removeAt(count[i]);
    }
    count.clear();
    if (!phone_selected) {
      for (int i = 0; i < globals.MyGlobals.search_result.length; i++) {
        if (globals.MyGlobals.search_result[i].group_id == 7 ||
            globals.MyGlobals.search_result[i].group_id == 8 ||
            globals.MyGlobals.search_result[i].group_id == 9 ||
            globals.MyGlobals.search_result[i].group_id == 10) {
          count.add(i);
        }
      }
    }
    if (!computer_selected) {
      for (int i = 0; i < globals.MyGlobals.search_result.length; i++) {
        if (globals.MyGlobals.search_result[i].group_id == 11 ||
            globals.MyGlobals.search_result[i].group_id == 12 ||
            globals.MyGlobals.search_result[i].group_id == 13 ||
            globals.MyGlobals.search_result[i].group_id == 14 ||
            globals.MyGlobals.search_result[i].group_id == 15) {
          count.add(i);
        }
      }
    }
    count.sort();
    for (int i = count.length - 1; i >= 0; i--) {
      globals.MyGlobals.search_result.removeAt(count[i]);
    }
    count.clear();
    if (min_price_ctrl.text != '' || max_price_ctrl.text != '') {
      for (int i = 0; i < globals.MyGlobals.search_result.length; i++) {
        if (globals.MyGlobals.search_result[i].price <
                int.parse(min_price_ctrl.text) ||
            globals.MyGlobals.search_result[i].price >
                int.parse(max_price_ctrl.text)) {
          count.add(i);
        }
      }
    }
    count.sort();
    for (int i = count.length - 1; i >= 0; i--) {
      globals.MyGlobals.search_result.removeAt(count[i]);
    }
    count.clear();
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

  void pricechanged() {}

  void textchanged() {
    setState(() {
      if (ctrl.text == '') {
        isresultvisible = false;
      } else {
        isresultvisible = true;
      }
      for (int i = 0; i < stringresult.length; i++) {
        if (globals.MyGlobals.all_products[i].name.contains(ctrl.text) &&
            ctrl.text != '') {
          stringresult[j++] = globals.MyGlobals.all_products[i].name;
        } else {
          stringresult[j++] = "";
        }
      }
      j = 0;
    });
  }

  Widget build(BuildContext context) {
    setState(() {
      if (MediaQuery.of(context).viewInsets.bottom > 0) {
        bottom_barState.visible = false;
      } else {
        bottom_barState.visible = true;
        isresultvisible = false;
      }
    });
    dev_width = device_dimensions(context).dev_width;
    dev_height = device_dimensions(context).dev_height;
    amazon_width =
        ebay_width = walmart_width = jumia_width = 7 * dev_width / 16;
    amazon_height =
        ebay_height = walmart_height = jumia_height = dev_height / 8;
    return WillPopScope(
      onWillPop: _onpress,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Background(),
            GestureDetector(
              onTap: () {
                setState(() {
                  FocusScope.of(context).requestFocus(FocusNode());
                });
              },
              child: Container(
                width: dev_width,
                height: dev_height * 0.9,
                child: new ListView(
                  children: <Widget>[
                    Container(
                      height: dev_height / 2,
                      alignment: Alignment(0, 1),
                      child: Container(
                        width: dev_width * 0.8,
                        child: TextField(
                          focusNode: _focus,
                          controller: ctrl,
                          cursorColor: globals.MyGlobals.lightcolor,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: globals.MyGlobals.lightcolor
                                      .withOpacity(0.3),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: globals.MyGlobals.lightcolor
                                      .withOpacity(0.3),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelText: '   ',
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isresultvisible,
                      child: Container(
                        height: dev_height / 8,
                        alignment: Alignment(0, -1),
                        child: Container(
                          height: 100,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: stringresult.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Visibility(
                                visible: ctrl.text != "" ? true : false,
                                child: Container(
                                  alignment: Alignment(0, 0),
                                  child: Visibility(
                                    visible: stringresult[index] != ""
                                        ? true
                                        : false,
                                    child: Container(
                                      margin: EdgeInsets.all(15),
                                      width: 150,
                                      height: 75,
                                      decoration: BoxDecoration(
                                        color: globals.MyGlobals.lightcolor
                                            .withOpacity(0.3),
                                        border: Border.all(
                                          color: Colors.transparent,
                                          width: 0,
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
                                          style: TextStyle(
                                              color:
                                                  globals.MyGlobals.lightcolor),
                                        )),
                                      ),
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
                    Container(
                      height: dev_height / 3.66,
                      alignment: Alignment(0,0),
                      child: Container(
                        width: dev_width / 5.49,
                        height: dev_height / 20.9,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Switch(
                          onChanged: (bool value){
                            setState(() {
                              ticked = value;
                              Scrollable.ensureVisible(scroll_it.currentContext);
                            });
                          },
                          value: ticked,
                          inactiveTrackColor: Colors.transparent,
                          inactiveThumbColor: Colors.white,
                          activeTrackColor: Colors.transparent,
                          activeColor: Colors.white,
                        ),
                      ),
                    ),
                    Divider(height: dev_height / 8,color: Colors.transparent,),
                    Container(
                      height: dev_height / 2,
                      width: dev_width,
                      alignment: Alignment(0,0),
                      child: Container(
                        key: scroll_it,
                        width: dev_width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          border: Border.all(color: Colors.transparent,width: 0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )
                  ],
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
