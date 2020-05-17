import 'package:flutter/material.dart';
import 'package:pfe_mobile/clipping_home.dart';
import 'package:pfe_mobile/device_dimensions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController controller;
  AnimationController icon_controller;
  AnimationController welcomeText_controller;
  AnimationController icoAlignment_controller;
  AnimationController BgColor_controller;
  Animation<double> iconAnim;
  Animation<double> logoAnim;
  Animation<double> firstico_Anim;
  Animation<double> secondico_Anim;
  Animation<double> welcomeAnim;
  Animation<double> BgColorAnim;
  final double minG = 75;
  final double maxheight = 200;
  final double maxwidth = 500;
  final double maxOpacity = 1;
  double maxFirstAlignment = 0.7;
  double maxSecondAlignment = 1;
  double width = 0;
  double height = 0;
  double icon_opacity = 0;
  double text_opacity = 0;
  double wt_opacity = 0;
  double dev_width = 0, dev_height = 0;
  double firstAlignment = 0;
  double secondAlignment = 0;
  double G = 0;
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    BgColor_controller.dispose();
    controller.dispose();
    icoAlignment_controller.dispose();
    welcomeText_controller.dispose();
    icon_controller.dispose();
    _controller.dispose();
    super.dispose();
  }
  void initState() {
    super.initState();
    BgColor_controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    BgColorAnim = Tween<double>(begin: 0, end:60).animate(CurvedAnimation(
      parent: BgColor_controller,
      curve: Interval(0,1,curve: Curves.linear),
    ));
    BgColor_controller.addListener(() {
      setState(() {
        G = minG + 4 * BgColorAnim.value / 3;
      });
    });
    BgColor_controller.repeat(reverse: true);
    welcomeText_controller = AnimationController(vsync: this, duration: Duration(seconds: 4));
    welcomeAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: welcomeText_controller,
      curve: Interval(0.45, 1.0, curve: Curves.linear)));
    welcomeText_controller.addListener(() {
      setState(() {
          wt_opacity = maxOpacity * welcomeAnim.value;
      });
    });
    welcomeText_controller.forward();
    icon_controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    iconAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: icon_controller,
        curve: Interval(0.5, 1.0, curve: Curves.linear)));
    icoAlignment_controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    firstico_Anim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: icoAlignment_controller,
      curve: Interval(0.70, 1,curve: Curves.easeIn)
    ));
    secondico_Anim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: icoAlignment_controller,
        curve: Interval(0.8, 1,curve: Curves.easeIn)
    ));
    icoAlignment_controller.addListener((){
      setState(() {
        dev_width = new device_dimensions(context).dev_width;
        dev_height = new device_dimensions(context).dev_height;
        maxFirstAlignment = dev_width < dev_height ? 0.7 : 1.5;
        maxSecondAlignment = dev_width < dev_height ? 1 : 2.5;
        if(icoAlignment_controller.value > 0.75 && icoAlignment_controller.value < 1){
          firstAlignment = maxSecondAlignment * firstico_Anim.value;
        }
        if(icoAlignment_controller.value > 0.75 && icoAlignment_controller.value < 1 ){
            secondAlignment = maxFirstAlignment * secondico_Anim.value;
        }
        if(icoAlignment_controller.value < 0.75){
            firstAlignment = maxSecondAlignment;secondAlignment=maxFirstAlignment;
        }
      });
    });
    icoAlignment_controller.repeat();
    icon_controller.addListener(() {
      setState(() {
        dev_width = new device_dimensions(context).dev_width;
        dev_height = new device_dimensions(context).dev_height;
        icon_opacity = maxOpacity * iconAnim.value;
        text_opacity = maxOpacity * iconAnim.value;
      });
    });
    icon_controller.forward();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    logoAnim = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.4, 1.0, curve: Curves.elasticOut)));
    controller.addListener(() {
      setState(() {
        height = logoAnim.value * maxheight;
        width = logoAnim.value * maxwidth;
      });
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Startup(
        height: height,
        width: width,
        ico_opacity: icon_opacity,
        txt_opacity: text_opacity,
        dev_height: dev_height,
        dev_width: dev_width,
        wt_opacity: wt_opacity,
        firstAlignment: firstAlignment,
        secondAlignment: secondAlignment,
        BgColorG: G,
      ),
    );
  }
}

class Startup extends StatelessWidget {
  final double width, height, ico_opacity, txt_opacity, dev_height, dev_width,wt_opacity,
  firstAlignment, secondAlignment,BgColorG;

  Startup({
    this.width,
    this.height,
    this.ico_opacity,
    this.txt_opacity,
    this.dev_height,
    this.dev_width,
    this.wt_opacity,
    this.firstAlignment,
    this.secondAlignment,
    this.BgColorG,
  });

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment(0.0, -0.7),
          child: Container(
              width: width,
              height: height,
              child: Image(
                image: AssetImage('assets/images/HotPrice.png'),
              )),
        ),
        ClipPath(
          clipper: clipping_home(),
          child: Container(
            width: dev_width,
            height: dev_height,
            color: Color.fromRGBO(255, BgColorG.round(), 112, 0.8),
          ),
        ),
        Container(
          alignment: Alignment(0, 0.4),
          child: Container(
            alignment: Alignment(0,0),
            width: dev_width,
            height: dev_height/4,
            child: Text(
              "It's Hot out here. \nDon't you think ?",
              style: TextStyle(color: Colors.white.withOpacity(
                wt_opacity
              ), fontWeight: FontWeight.w500, fontSize: dev_height > dev_width ? dev_height/14.64 : dev_height/ 12.24),
            ),
          ),
        ),
        Container(
            alignment: Alignment(0, 1),
            child: Container(
              width: dev_width / 1.37,
              height: dev_height / 4.88,
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment(0, 1),
                    child: Container(
                        width: dev_width / 2.06,
                        height: dev_height / 5,
                        child: Center(
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                                fontSize: dev_height > dev_width ? dev_height/36.6 : dev_height / 20.6,
                                color: Colors.white.withOpacity(txt_opacity)),
                          ),
                        )),
                  ),
                  Container(
                    alignment: Alignment(0, 1),
                    child: Container(
                        width: dev_width / 2.06,
                        height: dev_height / 7.32,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              alignment: Alignment(
                                  0, firstAlignment),
                              child: Icon(
                                IconData(58831, fontFamily: 'MaterialIcons'),
                                size: dev_height > dev_width
                                    ? dev_width / 10.3
                                    : dev_height / 10.3,
                                color: Colors.white.withOpacity(txt_opacity),
                              ),
                            ),
                            Container(
                              alignment:
                                  Alignment(0, secondAlignment),
                              child: Icon(
                                IconData(58831, fontFamily: 'MaterialIcons'),
                                size: dev_height > dev_width
                                    ? dev_width / 10.3
                                    : dev_height / 10.3,
                                color: Colors.white.withOpacity(ico_opacity),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ))
      ],
    );
  }
}

