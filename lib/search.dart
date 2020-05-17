import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe_mobile/bottom_bar.dart';
import 'package:pfe_mobile/device_dimensions.dart';
import 'package:pfe_mobile/home.dart';
import 'package:pfe_mobile/product_detail.dart';
import 'package:pfe_mobile/searchresult.dart';
import 'package:pfe_mobile/side.dart';
import 'side.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  static AssetImage amazon_cheched_img,ebay_checked_img,walmart_checked_img,jumia_checked_img;
  List<String> stringtest = new List<String>();
  List<String> stringresult = new List<String>();
  static int j = 0;
  final ctrl = TextEditingController();
  final min_price_ctrl = TextEditingController();
  final max_price_ctrl = TextEditingController();
  FocusNode _focus = new FocusNode();
  FocusNode _maxpricefocus = new FocusNode();
  FocusNode _minpricefocus = new FocusNode();
  static bool focused,isresultvisible;
  static Color computer_color, phone_color;
  static bool computer_selected, phone_selected,phone_rotated;
  static String prv_name = '' ;
  static int product_index = 0;



  void initState() {
    super.initState();
    isamazon = isebay = iswalmart = isjumia = true;
    amazon_color = ebay_color =
        walmart_color = jumia_color = globals.MyGlobals.lightcolor.withOpacity(0.3);
    amazon_cheched_img = ebay_checked_img = walmart_checked_img = jumia_checked_img = checked_img;
    ctrl.addListener(textchanged);
    _focus.addListener(_onfocuschange);
    max_price_ctrl.addListener(pricechanged);
    min_price_ctrl.addListener(pricechanged);
    _maxpricefocus.addListener(_onfocuschange);
    _minpricefocus.addListener(_onfocuschange);
    focused = isresultvisible = false;
    computer_selected = phone_selected = true;
    computer_color = phone_color =  globals.MyGlobals.darkcolor;
    phone_rotated = false;
    for (int i = 0; i < globals.MyGlobals.all_products.length; i++) {
      stringresult.insert(i, '');
    }
  }
  void _onfocuschange(){
    setState(() {
      if(!focused){
        bottom_barState.visible = false;
        focused = true;
      }else{
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
  void search_filter(){
    globals.MyGlobals.search_result.clear();
    globals.MyGlobals.all_products.forEach((element) {globals.MyGlobals.search_result.add(element);});
    List<int> count = List<int>();
    if(!isjumia){
      for(int i = 0; i < globals.MyGlobals.search_result.length; i++){
        if(globals.MyGlobals.search_result[i].group_id == 9 || globals.MyGlobals.search_result[i].group_id == 15){
          count.add(i);
        }
      }
    }
    if(!isamazon){
      for(int i = 0; i < globals.MyGlobals.search_result.length; i++){
        if(globals.MyGlobals.search_result[i].group_id == 7 || globals.MyGlobals.search_result[i].group_id == 11 ){
          count.add(i);
        }
      }
    }
    if(!isebay){
      for(int i = 0; i < globals.MyGlobals.search_result.length; i++){
        if(globals.MyGlobals.search_result[i].group_id == 8 || globals.MyGlobals.search_result[i].group_id == 12 || globals.MyGlobals.search_result[i].group_id == 13 ){
          count.add(i);
        }
      }
    }
    if(!iswalmart){
      for(int i = 0; i < globals.MyGlobals.search_result.length; i++){
        if(globals.MyGlobals.search_result[i].group_id == 10 || globals.MyGlobals.search_result[i].group_id == 14 ){
          count.add(i);
        }
      }
    }
    count.sort();
    for(int i = count.length - 1; i >= 0; i--){
      globals.MyGlobals.search_result.removeAt(count[i]);
    }
    count.clear();
    if(!phone_selected){
      for(int i = 0; i < globals.MyGlobals.search_result.length; i++){
        if(globals.MyGlobals.search_result[i].group_id == 7 ||
            globals.MyGlobals.search_result[i].group_id == 8
            || globals.MyGlobals.search_result[i].group_id == 9
            || globals.MyGlobals.search_result[i].group_id == 10){
          count.add(i);
        }
      }
    }
    if(!computer_selected){
      for(int i = 0; i < globals.MyGlobals.search_result.length; i++){
        if(globals.MyGlobals.search_result[i].group_id == 11
            || globals.MyGlobals.search_result[i].group_id == 12
            || globals.MyGlobals.search_result[i].group_id == 13
            || globals.MyGlobals.search_result[i].group_id == 14
            || globals.MyGlobals.search_result[i].group_id == 15){
          count.add(i);
        }
      }
    }
    count.sort();
    for(int i = count.length - 1; i >= 0; i--){
      globals.MyGlobals.search_result.removeAt(count[i]);
    }
    count.clear();
    if(min_price_ctrl.text != '' || max_price_ctrl.text !=''){
      for(int i = 0; i < globals.MyGlobals.search_result.length; i++){
        if(globals.MyGlobals.search_result[i].price < int.parse(min_price_ctrl.text)
            || globals.MyGlobals.search_result[i].price > int.parse(max_price_ctrl.text)){
          count.add(i);
        }
      }
    }
    count.sort();
    for(int i = count.length - 1; i >= 0; i--){
      globals.MyGlobals.search_result.removeAt(count[i]);
    }
    count.clear();
    for(int i = 0; i < globals.MyGlobals.search_result.length; i++){
      if(!globals.MyGlobals.search_result[i].name.contains(ctrl.text)){
        count.add(i);
      }
    }
    count.sort();
    for(int i = count.length - 1; i >= 0; i--){
      globals.MyGlobals.search_result.removeAt(count[i]);
    }
    count.clear();
  }
  void pricechanged(){}
  void textchanged() {
    setState(() {
      if(ctrl.text == ''){
        isresultvisible = false;
      }else{
        isresultvisible = true;
      }
      for (int i = 0; i < stringresult.length; i++) {
        if (globals.MyGlobals.all_products[i].name.contains(ctrl.text) && ctrl.text != '') {
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
      if(MediaQuery.of(context).viewInsets.bottom > 0){
        bottom_barState.visible = false;
      }else{
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
            bottom_bar(),
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
                      height: dev_height / 8,
                      child: Center(
                        child: Container(
                          width: 300,
                          child: TextField(
                            focusNode: _focus,
                            controller: ctrl,
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
                    ),
                    Visibility(
                      visible : isresultvisible,
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
                                    visible:
                                        stringresult[index] != "" ? true : false,
                                    child: Container(
                                      margin: EdgeInsets.all(15),
                                      width: 150,
                                      height: 75,
                                      decoration: BoxDecoration(
                                        color: globals.MyGlobals.lightcolor.withOpacity(0.3),
                                        border: Border.all(
                                          color: Colors.transparent,
                                          width: 0,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: FlatButton(
                                        onPressed: () {
                                          setState(() {
                                            for(int i = 0; i < globals.MyGlobals.all_products.length; i++){
                                              if(globals.MyGlobals.all_products[i].name == stringresult[index]){
                                                product_index = i;
                                                break;
                                              }
                                            }
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => product_detail(product_index)),
                                            );
                                          });
                                        },
                                        child: Center(
                                            child: Text(
                                          '${stringresult[index]}',
                                          style: TextStyle(color: globals.MyGlobals.lightcolor),
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) =>
                                const Divider(),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 0.9 * dev_width,
                      height: dev_height / 12,
                      child: Center(
                        child: Container(
                          width: 0.5 * dev_width,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 0.5 * dev_width / 2,
                                alignment: Alignment(0, 0),
                                child: FlatButton(
                                  onPressed: (){
                                    setState(() {
                                      if(computer_selected){
                                        computer_selected = false;
                                        computer_color = globals.MyGlobals.lightcolor;
                                      }else{
                                        computer_selected = true;
                                        computer_color = globals.MyGlobals.darkcolor;
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: 0.5 * dev_width / 4,
                                    height: dev_height / 18,
                                    decoration: BoxDecoration(
                                      color: globals.MyGlobals.lightcolor.withOpacity(0.2),
                                      border: Border.all(
                                          color: Colors.transparent, width: 0),
                                      borderRadius:
                                      BorderRadius.circular(0.5 * dev_width),
                                    ),
                                    child: Icon(
                                      IconData(58122, fontFamily: 'MaterialIcons'),
                                      color: computer_color,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 0.5 * dev_width / 2,
                                alignment: Alignment(0, 0),
                                child: FlatButton(
                                  onPressed: (){
                                    setState(() {
                                      if(phone_selected){
                                        phone_selected = false;
                                        phone_color = globals.MyGlobals.lightcolor;
                                      }else{
                                        phone_selected = true;
                                        phone_color = globals.MyGlobals.darkcolor;
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: 0.5 * dev_width / 4,
                                    height: dev_height / 18,
                                    decoration: BoxDecoration(
                                      color: globals.MyGlobals.lightcolor.withOpacity(0.2),
                                      border: Border.all(
                                          color: Colors.transparent, width: 0),
                                      borderRadius:
                                      BorderRadius.circular(0.5 * dev_width),
                                    ),
                                    child: Icon(
                                      IconData(58148, fontFamily: 'MaterialIcons'),
                                      color: phone_color,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment(0, 1),
                      height: dev_height / 4,
                      child: Container(
                        height: 2 * dev_height / 8,
                        width: 7 * dev_width / 8,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: dev_height / 8,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    width: 7 * dev_width / 8,
                                    alignment: Alignment(-1, -1),
                                    child: Container(
                                        width: isjumia ? jumia_width  : jumia_width - 10,
                                        height: isjumia ? jumia_height : jumia_height - 10,
                                        color: jumia_color,
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              width: isjumia ? jumia_width  : jumia_width - 10,
                                              height: isjumia ? jumia_height : jumia_height - 10,
                                              child: FlatButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (isjumia) {
                                                      jumia_color = globals.MyGlobals.darkcolor
                                                          .withOpacity(0.3);
                                                      jumia_checked_img = unchecked_img;
                                                      isjumia = false;
                                                    } else {
                                                      jumia_color = globals.MyGlobals.lightcolor
                                                          .withOpacity(0.3);
                                                      jumia_checked_img = checked_img;
                                                      isjumia = true;
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  child: Image(
                                                    image: AssetImage(
                                                        'assets/images/jumialogo-x-4.png'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment(1, 1),
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                child: Image(
                                                  image: jumia_checked_img,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                  Container(
                                    width: 7 * dev_width / 8,
                                    alignment: Alignment(1, -1),
                                    child: Container(
                                        width: iswalmart ? walmart_width : walmart_width - 10,
                                        height: iswalmart ? walmart_height : walmart_height - 10,
                                        color: walmart_color,
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              width: iswalmart ? walmart_width : walmart_width - 10,
                                              height: iswalmart ? walmart_height : walmart_height - 10,
                                              child: FlatButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (iswalmart) {
                                                      walmart_color = globals.MyGlobals.darkcolor
                                                          .withOpacity(0.3);
                                                      walmart_checked_img = unchecked_img;
                                                      iswalmart = false;
                                                    } else {
                                                      walmart_color = globals.MyGlobals.lightcolor
                                                          .withOpacity(0.3);
                                                      walmart_checked_img = checked_img;
                                                      iswalmart = true;
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  child: SvgPicture.asset(
                                                      'assets/images/Walmart_logo.svg'),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment(1,1),
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                child: Image(
                                                  image: walmart_checked_img,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: dev_height / 8,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    width: 7 * dev_width / 8,
                                    alignment: Alignment(-1, 1),
                                    child: Container(
                                        width: isebay ? ebay_width : ebay_width - 10,
                                        height: isebay ? ebay_height : ebay_height - 10,
                                        color: ebay_color,
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              width: isebay ? ebay_width : ebay_width - 10,
                                              height: isebay ? ebay_height: ebay_height - 10 ,
                                              child: FlatButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (isebay) {
                                                      ebay_color = globals.MyGlobals.darkcolor
                                                          .withOpacity(0.3);
                                                      ebay_checked_img = unchecked_img;
                                                      isebay = false;
                                                    } else {
                                                      ebay_color = globals.MyGlobals.lightcolor
                                                          .withOpacity(0.3);
                                                      ebay_checked_img = checked_img;;
                                                      isebay = true;
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  child: SvgPicture.asset(
                                                      "assets/images/EBay_logo.svg"),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment(1, 1),
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                child: Image(
                                                  image: ebay_checked_img,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                  Container(
                                    width: 7 * dev_width / 8,
                                    alignment: Alignment(1, 1),
                                    child: Container(
                                        width: isamazon ? amazon_width : amazon_width - 10,
                                        height: isamazon ? amazon_height : amazon_height - 10,
                                        color: amazon_color,
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              width: isamazon ? amazon_width : amazon_width - 10,
                                              height: isamazon ? amazon_height: amazon_height - 10 ,
                                              child: FlatButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (isamazon) {
                                                      isamazon = false;
                                                      amazon_color = globals.MyGlobals.darkcolor
                                                          .withOpacity(0.3);
                                                      amazon_cheched_img = unchecked_img;
                                                    } else {
                                                      amazon_color = globals.MyGlobals.lightcolor
                                                          .withOpacity(0.3);
                                                      amazon_cheched_img = checked_img;
                                                      isamazon = true;
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  child: SvgPicture.asset(
                                                      "assets/images/Amazon_logo.svg"),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment(1, 1),
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                child: Image(
                                                  image: amazon_cheched_img,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height : 2.7 * dev_height / 8,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: dev_height / 16,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: dev_width / 5,
                                  child: Center(
                                    child: Text('Price Range :  ',style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: globals.MyGlobals.lightcolor,
                                    ),),
                                  ),
                                ),
                                Container(
                                  width: 3 * dev_width / 4,
                                  height: dev_height / 16,
                                  child: SizedBox(
                                    height: 1.0,
                                    child:  Center(
                                      child:  Container(
                                        margin:  EdgeInsetsDirectional.only(start: 1.0, end: 1.5),
                                        height: 1.0,
                                        color: globals.MyGlobals.lightcolor,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: dev_height / 8,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: dev_width / 6,
                                  child: Center(
                                    child: Text('From : ', style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: globals.MyGlobals.lightcolor,
                                    ),),
                                  ),
                                ),
                                Container(
                                  height: dev_height / 8,
                                  child: Center(
                                    child: Container(
                                      width: 300,
                                      child: TextField(
                                        controller: min_price_ctrl,
                                        keyboardType: TextInputType.numberWithOptions(),
                                        focusNode: _minpricefocus,
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
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height:  dev_height / 8,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: dev_width / 6,
                                  child: Center(
                                    child: Text('To : ', style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: globals.MyGlobals.lightcolor,
                                    ),),
                                  ),
                                ),
                                Container(
                                  height: dev_height / 8,
                                  child: Center(
                                    child: Container(
                                      width: 300,
                                      child: TextField(
                                        controller: max_price_ctrl,
                                        keyboardType: TextInputType.numberWithOptions(),
                                        focusNode: _maxpricefocus,
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
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ),
                    Container(
                      height: dev_height / 16,
                      alignment: Alignment(0,0.9),
                      child: Container(
                        width : dev_width,
                        height: dev_height / 16,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width :  dev_width,
                              height: dev_height / 16,
                              alignment: Alignment(0,0),
                              child: Container(
                                width: dev_width / 2,
                                child: FlatButton(
                                  onPressed: (){
                                    setState(() {
                                      search_filter();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Searchresult()),
                                      );
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: globals.MyGlobals.lightcolor.withOpacity(0.3),
                                      border: Border.all(width: 0, color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Search',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20, color: globals.MyGlobals.lightcolor,
                                        ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ),
                              ),
                            /*Container(
                              width: dev_height / 16,
                              height: dev_height / 16,
                              decoration: BoxDecoration(
                                border: Border.all(width: 0, color: Colors.transparent),
                                borderRadius: BorderRadius.circular(200),
                                color: globals.MyGlobals.lightcolor,
                              ),
                              child: Center(
                                child: Icon(
                                  IconData(59534, fontFamily: 'MaterialIcons'),
                                  color: Colors.orangeAccent.shade400,
                                ),
                              ),
                            ),*/
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        drawer: side_bar(),
      ),
    );
  }
}
