import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pfe_mobile/bottom_bar.dart';
import 'package:pfe_mobile/device_dimensions.dart';
import 'Globals.dart' as globals;
import 'background.dart';

class Custom_Search extends StatefulWidget {
  Custom_SearchState createState() => Custom_SearchState();
}

class Custom_SearchState extends State<Custom_Search> {
  static List<bool> categorie_choice = new List<bool>();
  static List<bool> provider_choice = new List<bool>();
  double dev_height, dev_width;
  static List<String> price_range = new List<String>();
  static List<bool> price_selected = new List<bool>();

  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  static void Custom_filter() {
    globals.MyGlobals.search_result.clear();
    globals.MyGlobals.all_products.forEach((element) {
      globals.MyGlobals.search_result.add(element);
    });
    List<int> count = List<int>();
    if (!provider_choice[3]) {
      for (int i = 0; i < globals.MyGlobals.search_result.length; i++) {
        if (globals.MyGlobals.search_result[i].group_id == 9 ||
            globals.MyGlobals.search_result[i].group_id == 15) {
          count.add(i);
        }
      }
    }
    if (!provider_choice[0]) {
      for (int i = 0; i < globals.MyGlobals.search_result.length; i++) {
        if (globals.MyGlobals.search_result[i].group_id == 7 ||
            globals.MyGlobals.search_result[i].group_id == 11) {
          count.add(i);
        }
      }
    }
    if (!provider_choice[1]) {
      for (int i = 0; i < globals.MyGlobals.search_result.length; i++) {
        if (globals.MyGlobals.search_result[i].group_id == 8 ||
            globals.MyGlobals.search_result[i].group_id == 12 ||
            globals.MyGlobals.search_result[i].group_id == 13) {
          count.add(i);
        }
      }
    }
    if (!provider_choice[2]) {
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


    if (!categorie_choice[0]) {
      for (int i = 0; i < globals.MyGlobals.search_result.length; i++) {
        if (globals.MyGlobals.search_result[i].group_id == 7 ||
            globals.MyGlobals.search_result[i].group_id == 8 ||
            globals.MyGlobals.search_result[i].group_id == 9 ||
            globals.MyGlobals.search_result[i].group_id == 10) {
          count.add(i);
        }
      }
    }
    if (!categorie_choice[1]) {
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



    if (price_selected[3]) {
      for (int i = 0; i < globals.MyGlobals.search_result.length; i++) {
        if (globals.MyGlobals.search_result[i].price < 2000) {
          count.add(i);
        }
      }
    }
    if (price_selected[0]) {
      for (int i = 0; i < globals.MyGlobals.search_result.length; i++) {
        if (globals.MyGlobals.search_result[i].price >= 500){
          count.add(i);
        }
      }
    }
    if (price_selected[1]) {
      for (int i = 0; i < globals.MyGlobals.search_result.length; i++) {
        if (globals.MyGlobals.search_result[i].price < 500 || globals.MyGlobals.search_result[i].price >= 1000) {
          count.add(i);
        }
      }
    }
    if (price_selected[2]) {
      for (int i = 0; i < globals.MyGlobals.search_result.length; i++) {
        if (globals.MyGlobals.search_result[i].price < 1000 || globals.MyGlobals.search_result[i].price >= 2000) {
          count.add(i);
        }
      }
    }
    count.sort();
    for (int i = count.length - 1; i >= 0; i--) {
      globals.MyGlobals.search_result.removeAt(count[i]);
    }
    count.clear();
  }

  Widget build(BuildContext context) {
    dev_width = device_dimensions(context).dev_width;
    dev_height = device_dimensions(context).dev_height;
    return Stack(
      children: <Widget>[
        Background(),
        Column(
          children: <Widget>[
            Divider(
              height: dev_height / 32,
              color: Colors.transparent,
            ),
            Container(
              height: dev_height / 32,
              alignment: Alignment(0, 0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: dev_width / 3,
                    child: Divider(
                      indent: 25,
                      endIndent: 10,
                      color: globals.MyGlobals.lightcolor,
                    ),
                  ),
                  Container(
                    width: dev_width / 3,
                    alignment: Alignment(0, 0),
                    child: Text(
                      'Choose Category :',
                      style: TextStyle(
                        color: globals.MyGlobals.lightcolor,
                        fontWeight: FontWeight.w200,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    width: dev_width / 3,
                    child: Divider(
                      indent: 10,
                      endIndent: 25,
                      color: globals.MyGlobals.lightcolor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: dev_height / 6,
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => Divider(
                  endIndent: dev_width / 3,
                  indent: 10,
                  height: dev_height / 64,
                ),
                itemCount: globals.MyGlobals.categorie_length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: dev_height / 28,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: dev_width / 2,
                          alignment: Alignment(-0.8,0),
                          child: Text(
                            '- ' + globals.MyGlobals.category[index].name,
                            style: TextStyle(
                              color: globals.MyGlobals.lightcolor,
                              fontWeight: FontWeight.w200,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Container(
                          width: dev_width / 2,
                          alignment: Alignment(0.9,0),
                          child: Container(
                            child: Container(
                              width: dev_width / 7,
                              height: dev_height / 20.9,
                              decoration: BoxDecoration(
                                border: Border.all(color:globals.MyGlobals.lightcolor, width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Switch(
                                onChanged: (bool value){
                                  setState(() {
                                    categorie_choice[index] = value;
                                  });
                                },
                                value: categorie_choice[index],
                                inactiveTrackColor: Colors.transparent,
                                inactiveThumbColor: globals.MyGlobals.lightcolor,
                                activeTrackColor: Colors.transparent,
                                activeColor: globals.MyGlobals.lightcolor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Divider(
              height: dev_height / 64,
              color: Colors.transparent,
            ),
            Container(
              height: dev_height / 48,
              alignment: Alignment(0, 0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: dev_width / 3,
                    child: Divider(
                      indent: 25,
                      endIndent: 10,
                      color: globals.MyGlobals.lightcolor,
                    ),
                  ),
                  Container(
                    width: dev_width / 3,
                    alignment: Alignment(0, 0),
                    child: Text(
                      'Choose Provider :',
                      style: TextStyle(
                        color: globals.MyGlobals.lightcolor,
                        fontWeight: FontWeight.w200,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    width: dev_width / 3,
                    child: Divider(
                      indent: 10,
                      endIndent: 25,
                      color: globals.MyGlobals.lightcolor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: dev_height / 3.5,
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => Divider(
                  endIndent: dev_width / 3,
                  indent: 10,
                  height: dev_height / 32,
                ),
                itemCount: globals.MyGlobals.provider_length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: dev_height / 28,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: dev_width / 2,
                          alignment: Alignment(-0.8,0),
                          child: Text(
                            '- ' + globals.MyGlobals.provider[index].name,
                            style: TextStyle(
                              color: globals.MyGlobals.lightcolor,
                              fontWeight: FontWeight.w200,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Container(
                          width: dev_width / 2,
                          alignment: Alignment(0.9,0),
                          child: Container(
                            child: Container(
                              width: dev_width / 7,
                              height: dev_height / 20.9,
                              decoration: BoxDecoration(
                                border: Border.all(color: globals.MyGlobals.lightcolor, width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Switch(
                                onChanged: (bool value){
                                  setState(() {
                                    provider_choice[index] = value;
                                  });
                                },
                                value: provider_choice[index],
                                inactiveTrackColor: Colors.transparent,
                                inactiveThumbColor: globals.MyGlobals.lightcolor,                                activeTrackColor: Colors.transparent,
                                activeColor: globals.MyGlobals.lightcolor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Divider(
              height: dev_height / 64,
              color: Colors.transparent,
            ),
            Container(
              height: dev_height / 32,
              alignment: Alignment(0, 0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: dev_width / 3,
                    child: Divider(
                      indent: 25,
                      endIndent: 10,
                      color: globals.MyGlobals.lightcolor,
                    ),
                  ),
                  Container(
                    width: dev_width / 3,
                    alignment: Alignment(0, 0),
                    child: Text(
                      'Choose Price :',
                      style: TextStyle(
                        color: globals.MyGlobals.lightcolor,
                        fontWeight: FontWeight.w200,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    width: dev_width / 3,
                    child: Divider(
                      indent: 10,
                      endIndent: 25,
                      color: globals.MyGlobals.lightcolor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: dev_height / 3,
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => Divider(
                  endIndent: 25,
                  indent: 25,
                  height: dev_height / 32,
                ),
                itemCount: price_range.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: dev_height / 20,
                    child: FlatButton(
                      onPressed: (){
                        setState(() {
                          for(int i = 0; i < globals.MyGlobals.price_range_length; i++ ){
                            price_selected[i] = false;
                          }
                          price_selected[index] = !price_selected[index];

                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: dev_width / 3,
                            alignment: Alignment(-0.8,0),
                            child: Text(
                              price_range[index],
                              style: TextStyle(
                                color: globals.MyGlobals.lightcolor,
                                fontWeight: FontWeight.w200,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Container(
                            width: dev_width / 2,
                            alignment: Alignment(1,0),
                            child: Visibility(
                              visible: price_selected[index],
                              child: Icon(
                                  IconData(58826, fontFamily: 'MaterialIcons'),
                                color: globals.MyGlobals.lightcolor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        bottom_bar(),
      ],
    );
  }
}
