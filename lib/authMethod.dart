import 'package:flutter/material.dart';
import 'package:pfe_mobile/auth.dart';
import 'package:pfe_mobile/clipping_auth.dart';
import 'package:pfe_mobile/device_dimensions.dart';

class authMethod_dynamic extends StatefulWidget{
  @override
  _authMethod_dynamicState createState() => _authMethod_dynamicState();
}
class _authMethod_dynamicState extends State<authMethod_dynamic> with TickerProviderStateMixin{
  AnimationController BgColor_controller;
  AnimationController quoteTextController;
  Animation<double> BgColorAnim;
  Animation<double> quoteTextAnim;
  final double minG = 75;
  final double maxOpacity = 1;
  double G = 0;
  double qt_opacity = 0;

  PageController _controller = PageController(
    initialPage: 0,
  );
  @override
  void dispose(){
    BgColor_controller.dispose();
    _controller.dispose();
    quoteTextController.dispose();
    super.dispose();
  }
  void initState(){
    super.initState();
    BgColor_controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    BgColorAnim = Tween<double>(begin: 0, end:60).animate(CurvedAnimation(
      parent: BgColor_controller,
      curve: Interval(0,1,curve: Curves.linear),
    ));
    BgColor_controller.addListener(() {
      setState(() {
        G = minG +  4 * BgColorAnim.value / 3;
      });
    });
    BgColor_controller.repeat(reverse: true);
    quoteTextController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    quoteTextAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: quoteTextController,
      curve: Interval(0.45, 1, curve: Curves.linear)
    ));
    quoteTextController.addListener((){
      setState(() {
        qt_opacity = quoteTextAnim.value * maxOpacity;
      });
    });
    quoteTextController.forward();
  }



  Widget build(BuildContext context){
    return Container(
      child: authMethod_static(
        qt_opacity : qt_opacity,
        G: G,
      ),
    );

  }
}
class authMethod_static extends StatelessWidget{
  final double qt_opacity;
  final double G;

  authMethod_static({
    this.qt_opacity,
    this.G,
  });
  
  @override
  Widget build(BuildContext context){
    double dev_width = device_dimensions(context).dev_width;
    double dev_height =  device_dimensions(context).dev_height;
    return Stack(
        children: <Widget>[
          ClipPath(
            clipper: clipping_auth(),
            child: Container(
              alignment: Alignment(0, -0.8),
              color: Color.fromRGBO(255, G.round(), 112, 0.8),
              child : Container(
                alignment: Alignment(0,-0.8),
                width: dev_width * 0.95 ,
                height: dev_height / 1.2,
                child: Text(
                  ' Drop down the price.\n    Turn up the heat.',
                  style: TextStyle(color: Colors.white.withOpacity(qt_opacity),
                      fontWeight: FontWeight.w200, fontSize: dev_height > dev_width ? dev_height/14.64 : dev_height/ 8.24),
                ),
              )
            ),
          ),
          Container(
            alignment: Alignment(-1,0.8),
            child: Container(
              width: dev_width,
              height: dev_height / 4,
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment(0,0),
                    child: FlatButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => auth_dynamic()),
                        );
                      },
                      child: Container(
                        width: dev_width / 2.06,
                        height: dev_height / 14.64,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                            color: Color.fromRGBO(235, G.round(), 74, 0.8),
                          ),
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: Center(
                          child: Text(
                              "Set up your account",
                            style: TextStyle(
                              color: Color.fromRGBO(235, G.round(), 74, 0.8),
                              fontWeight: FontWeight.w200,
                              fontSize: dev_height > dev_width ? dev_height/36.6 : dev_height / 20.6,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
    );
  }
}