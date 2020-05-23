import 'package:flutter/material.dart';
import 'package:pfe_mobile/background.dart';
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

  int search_index(int index){
    for(int i = 0; i < globals.MyGlobals.all_products.length; i++){
      if(globals.MyGlobals.all_products[i].id_product == globals.MyGlobals.search_result[index].id_product){
        return i;
      }
    }
  }
  Future<bool> _onpress() async{
    setState(() {
      bottom_barState.page_counter = 1;
      Navigator.pop(context);

    });
    return true;
  }
  @override
  Widget build(BuildContext context) {
    print(globals.MyGlobals.search_result.length);
    dev_width = device_dimensions(context).dev_width;
    dev_height = device_dimensions(context).dev_height;
    return WillPopScope(
      onWillPop: _onpress,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Background(),
            Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment(0,-0.9),
                  child: Container(
                    width: 3 * dev_width / 4,
                    height:  dev_height / 12,
                    alignment: Alignment(0,0),
                    child: Container(
                      alignment: Alignment(0,0),
                      width:  dev_width /  1.8,
                      height: dev_height / 20,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border:  Border.all(color: globals.MyGlobals.lightcolor,width: 0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Results',
                        style: TextStyle(fontSize: 20, color: globals.MyGlobals.lightcolor,fontWeight: FontWeight.w200),
                      ),
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
                                MaterialPageRoute(builder: (context) => product_detail(search_index(index))),
                              );
                            },
                            child: Container(
                              height: dev_height / 9.5,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.transparent,
                                  width: 0.0,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: <Widget>[
                                  VerticalDivider(width: dev_width / 32,color: Colors.transparent,),
                                  Container(
                                    width: dev_width / 5,
                                    height: dev_height / 12,
                                    child: Image.network(
                                      globals.MyGlobals.search_result[index].image,
                                    ),
                                  ),
                                  VerticalDivider(width: dev_width / 32,color: Colors.transparent,),
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
                                                fontWeight: FontWeight.w200,
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
                                                  'Price : ' + globals.MyGlobals.search_result[index].price.toString() + '\$',
                                                  style: TextStyle(
                                                      color: globals.MyGlobals.lightcolor,
                                                    fontWeight: FontWeight.w200,

                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: dev_width / 3,
                                                alignment: Alignment(1,0),
                                                child: Text(
                                                  'Provider : ${globals.MyGlobals.all_products[index].group_id}',
                                                  style: TextStyle(
                                                    color: globals.MyGlobals.lightcolor,
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                                ),
                                              ),
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
                          Divider(color: globals.MyGlobals.lightcolor,indent: dev_width / 41.2,endIndent: dev_width / 41.2,),
                    ),
                  ),
                ),
              ],
            ),
            bottom_bar(),
          ],
        ),
        drawer: side_bar(),
      ),
    );
  }
}