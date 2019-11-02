import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_indicator/page_indicator.dart';

import 'pages/ExportPages.dart';

class WelcomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WelcomeScreen();
  }
}

class WelcomeScreen extends State<StatefulWidget> {
  final _pageController = PageController(initialPage: 0, keepPage: false);
  @override
  void initState() {
    super.initState();
   }

  @override
  void didUpdateWidget(StatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
 
  double padding = 16;
  @override
  Widget build(BuildContext context) {
 
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          body: PageIndicatorContainer(
        child: new PageView(
          controller: _pageController,
          children: <Widget>[
            PageOneView("assets/images/7.jpg"),
            PageTwoView("assets/images/center1.jpg"),
            PageThreeView("assets/images/4.png"),
            PageFourView("assets/images/5.jpg"),
            
           
          ],
          scrollDirection: Axis.horizontal,
          reverse: false,
          onPageChanged: (int index) {
           },
        ),
        length: 4,
        align: IndicatorAlign.bottom,
        indicatorSpace: 20.0,
        padding: const EdgeInsets.all(60),
        indicatorColor: Color(0xFF00CCFF),
        indicatorSelectorColor: Color(0xFF3366FF),
        shape: IndicatorShape.circle(size: 10),
      )),
    );
  }
}
 