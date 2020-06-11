import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pfe_mobile/background.dart';
import 'package:pfe_mobile/device_dimensions.dart';
import 'package:pfe_mobile/setting_variables.dart';
import 'package:pfe_mobile/side.dart';
import 'bottom_bar.dart';
import 'dart:async';
import 'dart:io';
import 'Globals.dart' as globals;
import 'home.dart';


class settings extends StatefulWidget {
    settingsState createState() => settingsState();
}

class settingsState extends State<settings>{
  static Directory _externalDocumentsDirectory;
  static Future<File> _colorchanger;
  double dev_width, dev_height;
  static bool islight, isdark;

  void _changeColor(){
    setState(() {
      String strs = """$islight
$isdark""";
      _colorchanger = defaultConfigWriter(strs);
      configReader();
      if(globals.MyGlobals.islightmode == true && globals.MyGlobals.isdarkmode == false){
        globals.MyGlobals.lightcolor = Colors.white;
        globals.MyGlobals.darkcolor = Color.fromRGBO(59, 59, 59, 1);
      }
      if(globals.MyGlobals.islightmode == false && globals.MyGlobals.isdarkmode == true){
        globals.MyGlobals.lightcolor = Color.fromRGBO(59, 59, 59, 1);
        globals.MyGlobals.darkcolor = Colors.white;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Home()),
      );
    });
  }
  static Future<String> _requestExternalStorageDirectory() async{
    _externalDocumentsDirectory = await getExternalStorageDirectory();
    return _externalDocumentsDirectory.path;
  }
  static Future<File>  _localFile() async{
    final path = await _requestExternalStorageDirectory();
    return File('$path/settings.cfg');
  }
  static Future<File> defaultConfigWriter(String str) async {
    final file = await _localFile();
    return file.writeAsString(str);
  }
  static Future<setting_variables> configReader() async {
    int i = 0;
    var arr = [];
    var file = await _localFile();
    var path = file.path;
    await new File(path)
        .openRead()
        .map(utf8.decode)
        .transform(new LineSplitter())
        .forEach((l) {
            arr.insert(i, l == 'true' ? true : false);
            i++;
    });
    globals.MyGlobals.islightmode = arr[0];
    globals.MyGlobals.isdarkmode = arr[1];
    return new setting_variables(arr[0], arr[1]);
  }


  @override
  void initState(){
    super.initState();
    islight = true;
    isdark = false;
  }


  Future<bool> _onpress() async{
      bottom_barState.page_counter = 1;
      side_barState.lst_selected_side[4] = false;
      Navigator.pop(context);
    return true;
  }


  @override
  Widget build(BuildContext context){
    dev_width = device_dimensions(context).dev_width;
    dev_height = device_dimensions(context).dev_height;
    return FutureBuilder(
      future: _colorchanger,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
        }
        return WillPopScope(
          onWillPop: _onpress,
          child: Scaffold(
            body: Stack(
              children: <Widget>[
                Background(),
                Container(
                  width: dev_width,
                  height: dev_height * 0.9,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: dev_height / 12,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width : dev_width / 2,
                              alignment: Alignment(0,0),
                              child: Text(
                                'Theme and Style :',style: TextStyle(fontSize: 20,color: globals.MyGlobals.lightcolor,fontWeight: FontWeight.w200),
                              ),
                            ),
                            Container(
                              width: dev_width / 2,
                              alignment: Alignment(0,0.1),
                              child: Divider(color: globals.MyGlobals.lightcolor,endIndent: 15,thickness: 0.25,),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: dev_height / 8,
                        alignment: Alignment(0,0),
                        child: Container(
                          width: 0.95 * dev_width,
                          height: dev_height / 16,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: globals.MyGlobals.lightcolor,width: 0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 0.9 * dev_width / 2,
                                child: FlatButton(
                                  onPressed: (){
                                      islight = true;
                                      isdark = false;
                                      globals.MyGlobals.islightmode = islight;
                                      globals.MyGlobals.isdarkmode = isdark;
                                      _changeColor();
                                  },
                                  child: Text('Light mode', style: TextStyle(color: islight ? globals.MyGlobals.darkcolor : globals.MyGlobals.lightcolor,fontWeight: FontWeight.w300,),),
                                ),
                              ),
                              VerticalDivider(width: dev_width / 64,color: globals.MyGlobals.lightcolor,endIndent: 10,indent: 10,),
                              Container(
                                width: 0.9 * dev_width / 2,
                                child: FlatButton(
                                  onPressed: (){
                                      isdark = true;
                                      islight = false;
                                      globals.MyGlobals.islightmode = islight;
                                      globals.MyGlobals.isdarkmode = isdark;
                                      _changeColor();
                                  },
                                  child: Text('Dark mode', style: TextStyle(color: isdark ? globals.MyGlobals.darkcolor : globals.MyGlobals.lightcolor,fontWeight: FontWeight.w300),),
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
            ),
            drawer: side_bar(),
          ),
        );
      },
    );
  }
}

class settings_preferences{

}