import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe_mobile/bottom_bar.dart';
import 'package:pfe_mobile/custom_search.dart';
import 'package:pfe_mobile/home.dart';
import 'package:pfe_mobile/side.dart';
import 'package:pfe_mobile/simple_search.dart';
import 'side.dart';

class search extends StatefulWidget {
  @override
  searchState createState() => searchState();
}

class searchState extends State<search> {

  static bool customized = false;
  PageController _controller = PageController(
    initialPage: 0,
  );


  void initState(){
    super.initState();
    customized = false;
    Custom_SearchState.price_range.clear();
  }

  _onPageViewChange(int page){
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



  void pricechanged() {}


  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    setState(() {
      if (MediaQuery.of(context).viewInsets.bottom > 0) {
        Simple_SearchState.btn_visible = false;
        bottom_barState.visible = false;
        Simple_SearchState.isresultvisible = true;
      } else {
        Simple_SearchState.btn_visible = true;
        bottom_barState.visible = true;
        Simple_SearchState.isresultvisible = false;
      }
    });
    return WillPopScope(
      onWillPop: _onpress,
      child: Scaffold(
        body: PageView(
          controller: _controller,
          onPageChanged: _onPageViewChange,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Simple_Search(),
            Custom_Search(),
          ],
        ),
        drawer: side_bar(),
      ),
    );
  }
}
