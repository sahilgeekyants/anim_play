import 'package:anim_play/utils/scale_config.dart';
import 'package:flutter/material.dart';

import 'animation_carousel.dart';
import '../shoe_assets.dart';

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

  Widget horizontalLine() => Container(
        width: double.infinity,
        height: 0.8,
        color: Colors.grey.shade200,
      );

  Widget shoeTile(int index) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.transparent,
            height: 80.5,
            width: 140,
            child: Image.asset(
              ShoeAssets.images[index],
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(width: 20),
          Container(
            // color: Colors.blue,
            width: 150,
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Text(
                  ShoeAssets.names[index],
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  ShoeAssets.prices[index],
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      );

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
        child: ListView(
          physics: ClampingScrollPhysics(),
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
            //
            AnimationCarousel(),
            //
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sidespace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "10 OPTIONS",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  //
                  SizedBox(height: 20),
                  horizontalLine(),
                  SizedBox(height: 20),
                  shoeTile(0),
                  SizedBox(height: 5),
                  horizontalLine(),
                  SizedBox(height: 20),
                  shoeTile(1),
                  SizedBox(height: 5),
                  horizontalLine(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
