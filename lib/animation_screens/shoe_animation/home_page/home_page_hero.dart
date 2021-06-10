import 'package:anim_play/utils/scale_config.dart';
import 'package:flutter/material.dart';

class HomePageHero extends StatelessWidget {
  HomePageHero({Key key, this.tag, @required this.child}) : super(key: key);
  final Object tag;
  final Widget child;
  final double widthPoint = SizeScaleConfig.screenWidth / 375; //1
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
            Offset(end.topRight.dx + widthPoint * 25,
                end.topRight.dy - widthPoint * 160),
            Offset(end.bottomLeft.dx + widthPoint * 25,
                end.bottomLeft.dy - widthPoint * 160),
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
