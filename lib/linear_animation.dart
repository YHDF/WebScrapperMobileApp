import 'package:flutter/material.dart';
import 'package:pfe_mobile/device_dimensions.dart';
import 'package:pfe_mobile/product.dart';
import 'package:pfe_mobile/Category.dart';
import 'package:pfe_mobile/Provider.dart';
import 'package:pfe_mobile/home.dart';
import 'load.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Group.dart';
import 'Globals.dart' as globals;


class LoadingAnimation extends StatefulWidget{
  LoadingAnimationState createState() => LoadingAnimationState();
}
class LoadingAnimationState extends State<LoadingAnimation> with TickerProviderStateMixin{
  double dev_width,dev_height ;
  AnimationController line_controller;
  AnimationController logo_controller;
  Animation<double> line_animation;
  Animation<double> logo_animation_popup;
  double line_length = 0;
  double logo_vertical_alignment = 0;


  void Starter() async{
    await Future<Load> (() async {
      final response = await http.get('${globals.MyGlobals.link_start}/api/load');
      if (response.statusCode == 200) {
        return Load.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Load');
      }
    }).then((value) {
      value.group.forEach((element) { globals.MyGlobals.group_list.add(Group.fromJson(element));});
      value.product.forEach((element) { globals.MyGlobals.all_products.add(Product.fromJson(element));});
      value.product_by_visits.forEach((element) { globals.MyGlobals.most_visited.add(Product.fromJson(element));});
      value.best_product.forEach((element) { globals.MyGlobals.best_products.add(Product.fromJson(element));});
      value.category.forEach((element) { globals.MyGlobals.category.add(Category.fromJson(element)); });
      value.provider.forEach((element) { globals.MyGlobals.provider.add(Provider.fromJson(element)); });
    }).then((value){
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Home()),
      );
    });
  }
  void initState(){
    super.initState();
    Starter();
    line_controller = AnimationController(vsync: this, duration: Duration(seconds: 1),);
    line_animation = Tween<double>(begin: 0, end: 3 / 4).animate(CurvedAnimation(
      parent: line_controller,
      curve: Interval(0.5, 1, curve: Curves.linear),
    ));
    line_controller.addListener(() {
      setState(() {
          line_length = line_animation.value;
      });
    });
    line_controller.forward();

    logo_controller = AnimationController(vsync: this, duration: Duration(seconds: 1),);
    logo_animation_popup = Tween<double>(begin: -3, end: 1).animate(CurvedAnimation(
      parent: logo_controller,
      curve: Interval(0, 0.5, curve: Curves.elasticInOut),
    ));
    logo_controller.addListener(() {
      setState(() {
        logo_vertical_alignment = logo_animation_popup.value;
      });
    });
    logo_controller.forward();

  }
  @override
  void dispose(){
    line_controller.dispose();
    logo_controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context){
    dev_width = device_dimensions(context).dev_width;
    dev_height = device_dimensions(context).dev_height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1, -1),
            end: Alignment(1, 1),
            colors: [
              const Color.fromRGBO(236, 111, 102, 1),
              const Color.fromRGBO(243, 161, 131, 1),
            ], // whitish to gray
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: dev_height / 3,
              alignment: Alignment(0,logo_vertical_alignment),
              child: Container(
                width: 0.9 * dev_width ,
                height: dev_height / 8,
                alignment: Alignment(0,0),
                child: Image(
                  image: AssetImage('assets/images/HotPrice.png'),
                ),
              ),
            ),
            Divider(height: dev_height / 4,color: Colors.transparent,),//IconData(59498, fontFamily: 'MaterialIcons'),
            Container(
              height: dev_height / 2.7,
              width: 3 * dev_width / 4,
              alignment: Alignment(-1,0),
              child: Container(
                width: line_length * dev_width,
                height: dev_height / 300,
                color: globals.MyGlobals.lightcolor,
              ),
            )
          ],
        ),
      ),
    );
  }

}