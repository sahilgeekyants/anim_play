import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimationTwoBody extends StatefulWidget {
  @override
  _AnimationTwoBodyState createState() => _AnimationTwoBodyState();
}

class _AnimationTwoBodyState extends State<AnimationTwoBody>
    with SingleTickerProviderStateMixin {
  //
  AnimationController controller;
  Animation sizeAnimation;
  Animation<Color> colorAnimation;
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
      weight: 1.0,
      tween: ColorTween(begin: Colors.green, end: Colors.yellow),
    ),
    TweenSequenceItem(
      weight: 2.0,
      tween: ColorTween(begin: Colors.yellow, end: Colors.red),
    ),
  ]);
  bool isAnimationCompleted = false;
  //

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    sizeAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 50.0, end: 500.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 500.0, end: 250.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 250.0, end: 375.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 375.0, end: 300.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 300.0, end: 500.0), weight: 1),
    ]).animate(controller);
    colorAnimation = bgColor.animate(controller);
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
        title: Text('Animation Tweens Chaining'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!controller.isAnimating) {
            print('click');
            try {
              if (!isAnimationCompleted) {
                print('animation forward');
                setState(() {
                  isAnimationCompleted = true;
                });
                await controller.forward().orCancel;
              } else {
                print('animation backward');
                setState(() {
                  isAnimationCompleted = false;
                });
                await controller.reverse().orCancel;
              }
            } on TickerCanceled {
              // the animation got canceled, probably because we were disposed
            }
          }
        },
        child:
            Icon(isAnimationCompleted ? Icons.rotate_left : Icons.rotate_right),
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, widget) {
          return Center(
            child: Container(
              height: sizeAnimation.value,
              width: sizeAnimation.value / 2,
              decoration: BoxDecoration(color: colorAnimation.value),
            ),
          );
        },
      ),
    );
  }
}
