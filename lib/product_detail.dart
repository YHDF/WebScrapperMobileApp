import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_mobile/bottom_bar.dart';
import 'package:pfe_mobile/message.dart';
import 'package:pfe_mobile/side.dart';
import 'Globals.dart' as globals;
import 'device_dimensions.dart';
import 'home.dart';
import 'package:url_launcher/url_launcher.dart';

class product_detail extends StatefulWidget {
  int counter;
  product_detail(int counter){
    this.counter = counter;
  }
  product_detailState createState() => product_detailState(counter: counter);
}

class product_detailState extends State<product_detail> {
  int counter;
  product_detailState({this.counter});
  Future<void> _launched;
  static double dev_width, dev_height;
  static String prv_name = '' ;


  void initState(){
    super.initState();
    visit_counter();
    for(int i = 0; i < globals.MyGlobals.group_list.length; i++ ){
      if(globals.MyGlobals.all_products[counter].group_id == globals.MyGlobals.group_list[i].id_group){
        for(int j = 0; j < globals.MyGlobals.provider.length;j++){
          if(globals.MyGlobals.provider[j].id_provider == globals.MyGlobals.group_list[i].provider_id){
            prv_name = globals.MyGlobals.provider[j].name;
          }
        }
      }
    }
  }

  Future<bool> _onpress() async {
    setState(() {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    });
    return true;
  }

  void visit_counter() async{
    await Future<Message>(() async{
      final response = await http.post('${globals.MyGlobals.link_start}/api/visit?api_token=${globals.MyGlobals.api_token}&product_id=${globals.MyGlobals.all_products[counter].id_product}');
      if (response.statusCode == 200) {
        return Message.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Message');
      }
    });
  }

  void add_to_favorites() async{
    await Future<Message>(() async{
      final response = await http.post('${globals.MyGlobals.link_start}/api/favourite?api_token=${globals.MyGlobals.api_token}&product_id=${globals.MyGlobals.all_products[counter].id_product}');
      if (response.statusCode == 200) {
        return Message.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Message');
      }
    });
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('');
    } else {
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    dev_width = device_dimensions(context).dev_width;
    dev_height = device_dimensions(context).dev_height;
    return WillPopScope(
      onWillPop: _onpress,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            bottom_bar(),
            Container(
              height: dev_height * 0.9,
              padding: EdgeInsets.only(top: 25),
              child: ListView(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Visibility(
                        visible: true,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: dev_height > dev_width
                                  ? dev_width / 4
                                  : dev_height / 4,
                              height: dev_height > dev_width
                                  ? dev_width / 4
                                  : dev_height / 4,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, width: 1.0),
                                  borderRadius:
                                  BorderRadius.circular(dev_width / 8),
                                ),
                                child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(dev_width),
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          width: dev_height > dev_width
                                              ? dev_width / 4
                                              : dev_height / 4,
                                          height: dev_height > dev_width
                                              ? dev_width / 4
                                              : dev_height / 4,
                                          child: Image.network(
                                            globals.MyGlobals.all_products[counter].image,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Container(
                                          width: dev_height > dev_width
                                              ? dev_width / 4
                                              : dev_height / 4,
                                          height: dev_height > dev_width
                                              ? dev_width / 4
                                              : dev_height / 4,
                                          child: FlatButton(
                                            onPressed: (){
                                            },
                                            child: null,
                                          ),
                                        )
                                      ],
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment(0.7, -0.8),
                        child: Container(
                            width: 2 * dev_width / 3,
                            height: dev_height / 6,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.transparent, width: 0.0),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.3),
                            ),
                            alignment: Alignment(-1, -0.9),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: dev_width / 2,
                                  height: dev_height / 16,
                                  child: ListView(
                                    children: <Widget>[
                                      Text(
                                        globals.MyGlobals.all_products[counter].name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: dev_height > dev_width
                                              ? dev_width / 16.44
                                              : dev_height / 29.24,
                                        ),
                                      ),
                                    ],
                                  )
                                ),
                                Divider(
                                  height: 5,
                                  color: Colors.white,
                                  endIndent: 20,
                                  indent: 20,
                                ),
                                Container(
                                  width: 2 * dev_width / 3,
                                  height: dev_height / 12,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: dev_width / 5,
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment(0, -1),
                                              child: Container(
                                                height: dev_height / 24,
                                                child: Center(
                                                  child: Text(
                                                    'Price',
                                                    style: TextStyle(
                                                      fontSize: dev_height >
                                                          dev_width
                                                          ? dev_width / 20.55
                                                          : dev_height / 36.55,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment(0, 1),
                                              child: Container(
                                                height: dev_height / 24,
                                                child: Center(
                                                  child: Text(
                                                    globals.MyGlobals.all_products[counter].price.toString()+'\$',
                                                    style: TextStyle(
                                                      fontSize: dev_height >
                                                          dev_width
                                                          ? dev_width / 20.55
                                                          : dev_height / 36.55,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: dev_width / 5,
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment(0, -1),
                                              child: Container(
                                                height: dev_height / 24,
                                                child: Center(
                                                  child: Text(
                                                    'Reviews',
                                                    style: TextStyle(
                                                      fontSize: dev_height >
                                                          dev_width
                                                          ? dev_width / 20.55
                                                          : dev_height / 36.55,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment(0, 1),
                                              child: Container(
                                                height: dev_height / 24,
                                                child: Center(
                                                  child: Text(
                                                    '100',
                                                    style: TextStyle(
                                                      fontSize: dev_height >
                                                          dev_width
                                                          ? dev_width / 20.55
                                                          : dev_height / 36.55,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: dev_width / 5,
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment(0, -1),
                                              child: Container(
                                                height: dev_height / 24,
                                                child: Center(
                                                  child: Text(
                                                    'Provider',
                                                    style: TextStyle(
                                                      fontSize: dev_height >
                                                          dev_width
                                                          ? dev_width / 20.55
                                                          : dev_height / 36.55,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment(0, 1),
                                              child: Container(
                                                height: dev_height / 24,
                                                child: Center(
                                                  child: Text(
                                                    prv_name,
                                                    style: TextStyle(
                                                      fontSize: dev_height >
                                                          dev_width
                                                          ? dev_width / 20.55
                                                          : dev_height / 36.55,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                  Divider(),
                  Column(
                    children: <Widget>[
                      Container(
                        height: dev_height / 24,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: dev_width / 3,
                              alignment: Alignment(0, 0.5),
                              child: Divider(
                                color: Colors.white,
                                indent: 5,
                                endIndent: 5,
                              ),
                            ),
                            Container(
                                width: dev_width / 3,
                                child: Center(
                                  child: Text(
                                    'Actions :',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                )),
                            Container(
                              width: dev_width / 3,
                              alignment: Alignment(0, 0.5),
                              child: Divider(
                                color: Colors.white,
                                indent: 5,
                                endIndent: 5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: dev_height / 5,
                        child: Center(
                          child: Container(
                            width: dev_width * 0.9,
                            height: dev_height / 6,
                            decoration: BoxDecoration(
                              border:
                              Border.all(color: Colors.transparent, width: 0.0),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.3),
                            ),
                            child: Container(
                              height: dev_height / 12,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 0.9 * 0.75 * dev_width,
                                    child: FlatButton(
                                      onPressed: () {
                                        setState(() {
                                          _launched = _launchInBrowser(globals.MyGlobals.all_products[counter].link.toString());
                                          });
                                      },
                                      child: Container(
                                        width: dev_width / 2,
                                        height: dev_height / 16,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.transparent,
                                              width: 0.0),
                                          borderRadius: BorderRadius.circular(20),
                                          color: Color.fromRGBO(255, 141, 133, 1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Visit Web Page',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 0.9 * 0.25 * dev_width,
                                    child: FlatButton(
                                      onPressed: () {
                                        add_to_favorites();
                                      },
                                      child: Container(
                                        width: dev_width / 7,
                                        height: dev_width / 7,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.transparent,
                                              width: 0.0),
                                          borderRadius:
                                          BorderRadius.circular(dev_width),
                                          color: Color.fromRGBO(255, 141, 133, 1),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            IconData(59517,
                                                fontFamily: 'MaterialIcons'),
                                            color: Colors.white,
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
                    ],
                  ),
                  Container(
                    height: dev_height / 24,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: dev_width / 3,
                          alignment: Alignment(0, 0.5),
                          child: Divider(
                            color: Colors.white,
                            indent: 5,
                            endIndent: 5,
                          ),
                        ),
                        Container(
                            width: dev_width / 3,
                            child: Center(
                              child: Text(
                                'Similar Products :',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )),
                        Container(
                          width: dev_width / 3,
                          alignment: Alignment(0, 0.5),
                          child: Divider(
                            color: Colors.white,
                            indent: 5,
                            endIndent: 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: dev_height / 3,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: dev_width / 2,
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: dev_width / 2,
                                height: dev_height / 8,
                                child: Image.network(
                                  globals.MyGlobals.all_products[index + 1].image,
                                ),
                              ),
                              Container(
                                height: dev_height / 5,
                                width: dev_width / 2,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  border: Border.all(
                                    width: 0,
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: dev_height / 15,
                                      child: Container(
                                        width: dev_width / 2.5,
                                        child: ListView(
                                          children: <Widget>[
                                            Center(
                                              child: Text(globals.MyGlobals.all_products[index + 1].name,style: TextStyle(color: Colors.white),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: dev_height / 15,
                                      child: Text('Price : ' + globals.MyGlobals.all_products[index + 1].price.toString() +'\$',style: TextStyle(color: Colors.white),),
                                    ),
                                    Container(
                                      height: dev_height / 15,
                                      child: Text('Reviews : 0',style: TextStyle(color: Colors.white),),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          VerticalDivider(
                            thickness: 5,
                            color: Colors.transparent,
                          ),
                    ),
                  )
                ],
              ),
            ),
            FutureBuilder<void>(future: _launched, builder: _launchStatus),
          ],
        ),
        drawer: side_bar(),
      ),
    );
  }
}
