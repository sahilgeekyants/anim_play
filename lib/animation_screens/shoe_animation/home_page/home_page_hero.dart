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
        return RectTween(
          begin: Rect.fromPoints(
            begin.topRight,
            begin.bottomLeft,
          ),
          end: Rect.fromPoints(
            Offset(end.topRight.dx + 25, end.topRight.dy - 160),
            Offset(end.bottomLeft.dx + 25, end.bottomLeft.dy - 160),
          ),
        );
      },
      flightShuttleBuilder:
          (flightContext, animation, direction, fromContext, toContext) {
        print('Hero animation status:${animation.status}');
        final Hero toHero = toContext.widget;
        return SizeTransition(
          sizeFactor: animation, // in order to avoid size variation
          child: RotationTransition(
            turns: animation.drive(
              Tween<double>(begin: -30 / 360, end: 0),
            ),
            child: toHero.child,
          ),
        );
      },
      child: child,
    );
  }
}
