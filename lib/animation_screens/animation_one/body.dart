import 'package:flutter/material.dart';
import 'tweens.dart';

class AnimationBody extends StatelessWidget {
  AnimationBody({
    Key key,
    @required AnimationController myController,
  }) : myTweens = Tweens(myController);
  final Tweens myTweens;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: myTweens.controller, builder: _buildAnimation);
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Center(
      child: Container(
        height: myTweens.sizeAnimation.value,
        width: myTweens.sizeAnimation.value,
        color: myTweens.colorAnimation.value,
      ),
    );
  }
}
