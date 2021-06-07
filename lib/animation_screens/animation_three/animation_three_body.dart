import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimationThreeBody extends StatefulWidget {
  @override
  _AnimationThreeBodyState createState() => _AnimationThreeBodyState();
}

class _AnimationThreeBodyState extends State<AnimationThreeBody>
    with SingleTickerProviderStateMixin {
  //
  AnimationController controller;
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
        title: Text('Rotate Animation Tween'),
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
            child: widget,
          );
        },
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
              height: 200,
              width: 200,
              color: Colors.redAccent,
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, widget) {
                  return Transform.rotate(
                    angle: rotationAnimationInside.value,
                    child: Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        color: colorAnimationInside.value,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
