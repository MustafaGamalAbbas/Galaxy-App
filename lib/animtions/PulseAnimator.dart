import 'package:flutter/material.dart';

class PulseAnimator extends StatefulWidget {
  final Widget child;
  PulseAnimator(this.child, {Key key}) : super(key: key);
  _PulseAnimatorState createState() => _PulseAnimatorState(child);
}

class _PulseAnimatorState extends State<PulseAnimator>
    with TickerProviderStateMixin {
  Widget child;
  AnimationController controller;
  Animation<Offset> pulseAnimation;
  _PulseAnimatorState(this.child);

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 1000), vsync: this)
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FadeTransition(
        opacity: TweenAndBack(begin: 0.5, end: 1.0).animate(controller),
        child: this.child,
      ),
    );
  }
  @override
  void dispose() {
    controller.dispose(); 
     super.dispose();
  }
}

class TweenAndBack<T> extends Tween<T> {
  TweenAndBack({T begin, T end}) : super(begin: begin, end: end);
  @override
  T lerp(double t) {
    return super.lerp(t);
  }
}
