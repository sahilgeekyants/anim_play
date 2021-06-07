import 'package:flutter/material.dart';

class Tweens {
  Tweens(this.controller)
      : sizeAnimation = Tween<double>(begin: 100.0, end: 300.0).animate(
            CurvedAnimation(parent: controller, curve: Interval(0.0, 0.5))),
        colorAnimation = ColorTween(begin: Colors.red, end: Colors.blue)
            .animate(
                CurvedAnimation(parent: controller, curve: Interval(0.5, 1.0)));

  //
  final AnimationController controller;
  final Animation sizeAnimation;
  final Animation colorAnimation;
}
