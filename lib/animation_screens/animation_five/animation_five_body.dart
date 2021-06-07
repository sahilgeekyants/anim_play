import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimationFiveBody extends StatefulWidget {
  @override
  _AnimationFiveBodyState createState() => _AnimationFiveBodyState();
}

class _AnimationFiveBodyState extends State<AnimationFiveBody>
    with SingleTickerProviderStateMixin {
  //
  AnimationController controller;
  Animation<BorderRadius> transitionAnimationInside;
  Animatable<BorderRadius> borderSquence = TweenSequence([
    TweenSequenceItem(
        tween: BorderRadiusTween(
            begin: BorderRadius.circular(0), end: BorderRadius.circular(125)),
        weight: 3),
    TweenSequenceItem(
        tween: BorderRadiusTween(
            begin: BorderRadius.circular(125), end: BorderRadius.circular(0)),
        weight: 1),
    TweenSequenceItem(
        tween: BorderRadiusTween(
            begin: BorderRadius.circular(0), end: BorderRadius.circular(125)),
        weight: 3),
    TweenSequenceItem(
        tween: BorderRadiusTween(
            begin: BorderRadius.circular(125), end: BorderRadius.circular(0)),
        weight: 1),
  ]);
  // BorderRadiusTween
  Animation<Offset> slideAnimationInside;
  Animatable<Offset> slideInsideTweenSequence = TweenSequence<Offset>([
    TweenSequenceItem<Offset>(
        tween: Tween(begin: Offset(0.5, -0.5), end: Offset(0.5, 0.5)),
        weight: 1),
    TweenSequenceItem<Offset>(
        tween: Tween(begin: Offset(0.5, 0.5), end: Offset(-0.5, 0.5)),
        weight: 1),
    TweenSequenceItem<Offset>(
        tween: Tween(begin: Offset(-0.5, 0.5), end: Offset(-0.5, -0.5)),
        weight: 1),
    TweenSequenceItem<Offset>(
        tween: Tween(begin: Offset(-0.5, -0.5), end: Offset(0.5, -0.5)),
        weight: 1),
  ]);
  Animation rotationAnimation;
  Animatable<double> rotationTween = TweenSequence<double>([
    TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 3.14), weight: 2.5),
    TweenSequenceItem(tween: Tween<double>(begin: 3.14, end: 0.0), weight: 1),
    TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 3.14), weight: 1),
    TweenSequenceItem(tween: Tween<double>(begin: 3.14, end: 0.0), weight: 2.5),
  ]);
  Animation rotationAnimationInside;
  Animatable<double> rotationTweenInside = TweenSequence<double>([
    TweenSequenceItem(tween: Tween<double>(begin: 3.14, end: 0.0), weight: 1),
    TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 3.14), weight: 1),
    TweenSequenceItem(tween: Tween<double>(begin: 3.14, end: 0.0), weight: 1),
    TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 3.14), weight: 1),
  ]);
  Animation<Color> colorAnimationInside;
  Animatable<Color> bgColor = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Colors.red, end: Colors.blue),
    ),
    TweenSequenceItem(
      weight: 2.0,
      tween: ColorTween(begin: Colors.blue, end: Colors.green),
    ),
    TweenSequenceItem(
      weight: 2.0,
      tween: ColorTween(begin: Colors.green, end: Colors.yellow),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Colors.yellow, end: Colors.red),
    ),
  ]);
  bool isAnimationCompleted = false;
  //

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 6));
    rotationAnimation = rotationTween.animate(controller);
    rotationAnimationInside = rotationTweenInside.animate(controller);
    colorAnimationInside = bgColor.animate(controller);
    slideAnimationInside = slideInsideTweenSequence.animate(controller);
    transitionAnimationInside = borderSquence.animate(controller);
    controller
      ..forward()
      ..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Shape Slide Color Rotation'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print('click');
          try {
            if (!controller.isAnimating) {
              setState(() {
                isAnimationCompleted = false;
              });
              controller
                ..forward()
                ..repeat();
            } else {
              setState(() {
                isAnimationCompleted = true;
              });
              controller.reset();
            }
          } on TickerCanceled {
            // the animation got canceled, probably because we were disposed
          }
          // }
        },
        child: Icon(isAnimationCompleted ? Icons.rotate_right : Icons.stop),
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, widget) {
          return Transform.rotate(
            angle: rotationAnimation.value,
            // angle: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  try {
                    if (!controller.isAnimating) {
                      setState(() {
                        isAnimationCompleted = false;
                      });
                      controller
                        ..forward()
                        ..repeat();
                    } else {
                      setState(() {
                        isAnimationCompleted = true;
                      });
                      controller.stop();
                    }
                  } on TickerCanceled {
                    // the animation got canceled, probably because we were disposed
                  }
                },
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: transitionAnimationInside.value,
                    color: Colors.redAccent,
                  ),
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, widget) {
                      return Transform.rotate(
                        angle: rotationAnimationInside.value,
                        child: Center(
                          child: SlideTransition(
                            position: slideAnimationInside,
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: colorAnimationInside.value,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
