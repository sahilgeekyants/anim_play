import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimationFourBody extends StatefulWidget {
  @override
  _AnimationFourBodyState createState() => _AnimationFourBodyState();
}

class _AnimationFourBodyState extends State<AnimationFourBody>
    with SingleTickerProviderStateMixin {
  //
  AnimationController controller;
  Animation sizeAnimationInner;
  Animatable<double> sizeTween = TweenSequence([
    TweenSequenceItem(tween: Tween(begin: 50.0, end: 250.0), weight: 2),
    TweenSequenceItem(tween: Tween(begin: 250.0, end: 100.0), weight: 1),
    TweenSequenceItem(tween: Tween(begin: 100.0, end: 200.0), weight: 1),
    TweenSequenceItem(tween: Tween(begin: 200.0, end: 50.0), weight: 1),
    TweenSequenceItem(tween: Tween(begin: 50.0, end: 250.0), weight: 2),
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
    sizeAnimationInner = sizeTween.animate(controller);
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
        title: Text('Size Color Rotation Animation'),
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
              height: 250,
              width: 250,
              color: Colors.redAccent,
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, widget) {
                  return Transform.rotate(
                    angle: rotationAnimationInside.value,
                    child: Center(
                      child: Container(
                        height: sizeAnimationInner.value,
                        width: sizeAnimationInner.value,
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
