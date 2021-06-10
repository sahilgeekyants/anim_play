import 'package:flutter/material.dart';

class DescriptionPageHero extends StatelessWidget {
  DescriptionPageHero({Key key, this.tag, @required this.child})
      : super(key: key);
  final Object tag;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      transitionOnUserGestures: true,
      // flightShuttleBuilder: (flightContext, animation, direction,
      //     fromContext, toContext) {
      //   print('Hero animation status:${animation.status}');
      //   final Hero toHero = toContext.widget;
      //   return RotationTransition(
      //     turns: animation.drive(
      //       Tween<double>(begin: -0.1, end: 0),
      //     ),
      //     child: toHero.child,
      //   );
      // },
      // createRectTween: (begin, end) {
      //   return RectTween(
      //     begin: Rect.fromCenter(
      //       center: begin.center,
      //       width: begin.width,
      //       height: begin.height,
      //     ),
      //     end: Rect.fromCenter(
      //       center: end.center,
      //       width: end.width,
      //       height: end.height,
      //     ),
      //   );
      // },
      child: child,
    );
  }
}
