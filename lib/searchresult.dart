import 'package:flutter/material.dart';
import 'package:pfe_mobile/product_detail.dart';
import 'package:pfe_mobile/side.dart';
import 'bottom_bar.dart';
import 'package:pfe_mobile/device_dimensions.dart';
import 'Globals.dart' as globals;
class Searchresult extends StatefulWidget {
  SearchresultState createState() => SearchresultState();


}
class SearchresultState extends State<Searchresult>{
  double dev_width,dev_height;
  Future<bool> _onpress() async{
    setState(() {
      bottom_barState.page_counter = 1;
      Navigator.pop(context);

    });
    return true;
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
            Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment(0,-0.9),
                  child: Container(
                    width: 3 * dev_width / 4,
                    height:  dev_height / 12,
                    alignment: Alignment(1,0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: dev_height > dev_width ? dev_width / 7 : dev_height / 7,
                          height: dev_height > dev_width ? dev_width / 7 : dev_height / 7,
                          decoration: BoxDecoration(
                            color: globals.MyGlobals.lightcolor.withOpacity(0.5),
                            border:  Border.all(color: Colors.transparent,width: 0.0),
                            borderRadius: BorderRadius.circular(dev_width),
                          ),
                          child: Center(
                            child: Icon(
                              IconData(59574, fontFamily: 'MaterialIcons'),
                              color: globals.MyGlobals.lightcolor,
                              size: 30,
                            ),
                          ),
                        ),
                        VerticalDivider(width: 5,color: Colors.transparent,),
                        Container(
                          alignment: Alignment(0,0),
                          width:  dev_width /  1.8,
                          height: dev_height / 20,
                          decoration: BoxDecoration(
                            color: globals.MyGlobals.lightcolor.withOpacity(0.5),
                            border:  Border.all(color: Colors.transparent,width: 0.0),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            'Search Result',
                            style: TextStyle(fontSize: 20, color: globals.MyGlobals.lightcolor,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment(-1, 0.3),
                  child: Container(
                    width:  dev_width,
                    height: 14 * dev_height / 18,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: globals.MyGlobals.search_result.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width : dev_width,
                          child: FlatButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => product_detail(index)),
                              );
                            },
                            child: Container(
                              height: 75,
                              decoration: BoxDecoration(
                                color: globals.MyGlobals.lightcolor.withOpacity(0.3),
                                border: Border.all(
                                  color: Colors.transparent,
                                  width: 0,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: dev_width / 5,
                                    child: Image.network(
                                      globals.MyGlobals.search_result[index].image,
                                    ),
                                  ),
                                  Container(
                                    width: dev_width / 2,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 35,
                                          child: Center(
                                            child: Text(
                                              globals.MyGlobals.search_result[index].name,
                                              style: TextStyle(
                                                color: globals.MyGlobals.lightcolor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 35,
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                width: dev_width / 6,
                                                alignment: Alignment(1,0),
                                                child: Text(
                                                  globals.MyGlobals.search_result[index].price.toString() + '\$',
                                                  style: TextStyle(
                                                      color: globals.MyGlobals.lightcolor
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: dev_width / 3,
                                                alignment: Alignment(1,0),
                                                child: Stack(
                                                  children: <Widget>[
                                                    Container(
                                                      alignment: Alignment(0,0),
                                                      child: Text(
                                                        'visit in website',
                                                        style: TextStyle(
                                                          color: globals.MyGlobals.lightcolor,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment: Alignment(1,0),
                                                      child: Icon(
                                                        IconData(58849, fontFamily: 'MaterialIcons', matchTextDirection: true),
                                                        color: globals.MyGlobals.lightcolor,
                                                        size: 15,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
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
              ],
            )
          ],
        ),
        drawer: side_bar(),
      ),
    );
  }
}