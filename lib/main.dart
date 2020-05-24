import 'package:flutter/material.dart';
import 'package:pfe_mobile/animation.dart';
import 'package:pfe_mobile/session_token.dart';
import 'package:pfe_mobile/setting_variables.dart';
import 'package:pfe_mobile/starting.dart';
import 'package:pfe_mobile/authMethod.dart';
import 'dart:async';
import 'Globals.dart' as globals;
import 'package:flutter/services.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
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
      return LoadingAnimation();
    }


  }
  _onPageViewChange(int page){
  }
}


