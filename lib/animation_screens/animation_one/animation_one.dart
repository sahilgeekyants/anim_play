import 'package:flutter/material.dart';

import 'body.dart';

class AnimationOne extends StatefulWidget {
  @override
  _AnimationState createState() => _AnimationState();
}

class _AnimationState extends State<AnimationOne>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation sizeAnimation;
  Animation colorAnimation;
  bool isAnimationCompleted = false;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
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
        title: Text('Animation Intervals'),
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
      body: AnimationBody(myController: controller),
    );
  }
}
