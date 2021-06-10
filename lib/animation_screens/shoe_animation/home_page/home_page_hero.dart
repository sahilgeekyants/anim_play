import 'package:flutter/material.dart';

class HomePageHero extends StatelessWidget {
  HomePageHero({Key key, this.tag, @required this.child}) : super(key: key);
  final Object tag;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      transitionOnUserGestures: true,
      createRectTween: (begin, end) {
        // print('end top right- dx:${end.topRight.dx}, dy:${end.topRight.dy}');
        // print(
        //     'end bottom left- dx:${end.bottomLeft.dx}, dy:${end.bottomLeft.dy}');
        return RectTween(
          // Rect.fromLTWH(left, top, width, height)
          // begin: Rect.fromCenter(
          //   center: begin.center,
          //   width: begin.width,
          //   height: begin.height,
          // ),
          begin: Rect.fromPoints(
            begin.topRight, begin.bottomLeft,
            // Offset(begin.topRight.dx,
            //     begin.topRight.dy - 35),
            // Offset(begin.bottomLeft.dx,
            //     begin.bottomLeft.dy - 35),
          ),
          end: Rect.fromPoints(
            Offset(end.topRight.dx, end.topRight.dy - 135),
            Offset(end.bottomLeft.dx, end.bottomLeft.dy - 135),
          ),
          // end: Rect.fromCircle(
          //     center: end.center, radius: end.height / 2),
        );
      },
      flightShuttleBuilder:
          (flightContext, animation, direction, fromContext, toContext) {
        print('Hero animation status:${animation.status}');
        final Hero toHero = toContext.widget;
        // final Hero fromHero = fromContext.widget;
        return SizeTransition(
          sizeFactor: animation.drive(Tween<double>(begin: 1, end: 2.5)),
          child: RotationTransition(
              turns: animation.drive(
                Tween<double>(begin: -0.1, end: 0),
              ),
              child:
                  // direction == HeroFlightDirection.push ?
                  toHero.child
              // : fromHero.child,
              ),
        );
      },
      child: child,
    );
  }
}
