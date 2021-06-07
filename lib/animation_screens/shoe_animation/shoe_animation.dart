import 'package:anim_play/utils/scale_config.dart';
import 'package:flutter/material.dart';

import 'animation_carousel.dart';

class ShoeAnimation extends StatefulWidget {
  @override
  _ShoeAnimationState createState() => _ShoeAnimationState();
}

class _ShoeAnimationState extends State<ShoeAnimation> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //save values of scale config
    SizeScaleConfig().calculateScaleRatios(context);
  }

  final double sidespace = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        actions: [
          Icon(
            Icons.search,
            color: Colors.black,
          ),
          SizedBox(width: 10),
        ],
        centerTitle: true,
        title: Text(
          'Shoe Animation',
          style: TextStyle(
            color: Colors.black,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: sidespace),
            child: Text(
              'Shoes',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Flexible(
            child: AnimationCarousel(),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sidespace),
            child: Text(
              "10 OPTIONS",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
