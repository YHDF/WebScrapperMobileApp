import 'package:flutter/material.dart';
import 'package:pfe_mobile/Category.dart';
import 'package:pfe_mobile/product.dart';
import 'package:pfe_mobile/Provider.dart';
import 'package:pfe_mobile/home.dart';
import 'package:pfe_mobile/session_token.dart';
import 'package:pfe_mobile/setting_variables.dart';
import 'package:pfe_mobile/starting.dart';
import 'package:pfe_mobile/authMethod.dart';
import 'dart:async';
import 'Globals.dart' as globals;
import 'load.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Group.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await setting_variables.defaultConfigWriter();
  //await session_token.SessionReader();
  await session_token.SessionReader();
  Future<setting_variables>((){
    return setting_variables.configReader();
  }).then((value) {
    if(value != null){
      if(value.lightmode == true && value.darkmode == false){
        globals.MyGlobals.lightcolor = Colors.white;
        globals.MyGlobals.darkcolor = Colors.black;
      }
      if(value.lightmode == false && value.darkmode == true){
        globals.MyGlobals.lightcolor = Colors.black;
        globals.MyGlobals.darkcolor = Colors.white;
      }
    }else{

    }
  });
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
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  PageController _controller = PageController(
    initialPage: 0,
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(globals.MyGlobals.api_token == ' '){
      return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: null,
        body: PageView(
          controller: _controller,
          scrollDirection: Axis.vertical,
          onPageChanged: _onPageViewChange,
          children: [
            HomePage(),
            authMethod_dynamic(),
          ],
        ),
      );
    }else{
      return Home();
    }


  }
  _onPageViewChange(int page){
  }
}


