import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClippingViewTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xff230242),
      body: ClipPath(
        clipper: CurveClipper(),
        child: new Image.network(
          "https://bit.ly/2nirIxg",
        ),
      ),
    );
  }
}

/*
 **/
class CurveCClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.moveTo(0.0, size.height);
    path.lineTo(0.0, size.height - 250);
    /* var firstControlPoint = Offset(size.width / 3, size.height - 350);
    var secondControlPoint = Offset(size.width * 0.75, size.height - 300);
    var firstEndPoint = Offset(size.width/2, size.height - 250);
    var secondEndPoint = Offset(size.width, size.height - 700);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx,
        firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx,
        secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    // path.lineTo(0.0,0.0);
    //path.lineTo(size.width*0., size.height);
    // path.quadraticBezierTo(x1, y1, x2, y2)
*/
    path.quadraticBezierTo(size.width * 0.25, size.height - 350,
        size.width * 0.5, size.height - 250);
    path.quadraticBezierTo(
        size.width * 0.75, size.height - 150, size.width, size.height - 250);

    path.lineTo(size.width, size.height - 250);
    path.lineTo(size.width, size.height - 100);
    path.quadraticBezierTo(size.width * 2 / 3, size.height - 20,
        size.width * 0.5, size.height - 100);
    path.quadraticBezierTo(
        size.width * 1 / 4, size.height - 200, 0.0, size.height - 250);
    path.lineTo(0.0, size.height - 250);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    // path starts with (0.0, 0.0) point (1)
    path.lineTo(0.0, size.height - 150);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 150);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SimpleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();

    path.lineTo(0.0, size.height - 100);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustomRectClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    // TODO: implement getClip
    return null;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    // TODO: implement shouldReclip
    return null;
  }
}

class CustomRRectClipper extends CustomClipper<RRect> {
  @override
  RRect getClip(Size size) {
    // TODO: implement getClip
    return null;
  }

  @override
  bool shouldReclip(CustomClipper<RRect> oldClipper) {
    // TODO: implement shouldReclip
    return null;
  }
}
//class CustomOvalClipper extends CustomClipper<>{}
