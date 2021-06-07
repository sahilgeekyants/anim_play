import 'package:flutter/material.dart';
import 'animation_screens/shoe_animation/shoe_animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: AnimationOne(),
      // home: AnimationTwoBody(),
      // home: AnimationThreeBody(),
      // home: AnimationFourBody(),
      // home: AnimationFiveBody(),
      home: ShoeAnimation(),
    );
  }
}
