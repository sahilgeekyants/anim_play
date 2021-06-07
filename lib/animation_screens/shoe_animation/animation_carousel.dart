import 'package:anim_play/utils/scale_config.dart';
import 'package:flutter/material.dart';

class AnimationCarousel extends StatefulWidget {
  @override
  _AnimationCarouselState createState() => _AnimationCarouselState();
}

class _AnimationCarouselState extends State<AnimationCarousel>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  AnimationController _animationController;
  Animation<double> rotationAnimation;
  int _currentPageIndex = 0;
  final double pie = 3.14;
  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: _currentPageIndex, viewportFraction: 0.8);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    rotationAnimation = Tween<double>(begin: pie * 0.15, end: pie * 0.3)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeOut));
  }

  List<Color> _colorList = [
    Colors.orangeAccent,
    Colors.purpleAccent,
    Colors.greenAccent,
    Colors.redAccent,
    Colors.yellowAccent,
  ];
  List<String> _names = [
    "KD13 EP",
    "FD15 RP",
    "KD23 FP",
    "FD15 EP",
    "KD13 RP",
  ];
  List<String> _prices = [
    "Rs 12,995",
    "Rs 11,495",
    "Rs 10,099",
    "Rs 12,995",
    "Rs 11,495",
  ];
  List<String> images = [
    "assets/blue_shoe.png",
    "assets/red_shoe.png",
    "assets/yellow_shoe.png",
  ];

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  final SizeScaleConfig scaleConfig = SizeScaleConfig();

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blueAccent,
      color: Colors.transparent,
      height: SizeScaleConfig.screenHeight * 0.38,
      width: SizeScaleConfig.screenWidth,
      child: PageView.builder(
        controller: _pageController,
        itemCount: 10,
        onPageChanged: (index) {
          print('page changed index : $index');
          _animationController.reset();
          _animationController.forward();
          _currentPageIndex = index;
        },
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
              left: scaleConfig.scaleHeight(5),
              right: scaleConfig.scaleHeight(5),
            ),
            // color: Colors.red,
            color: Colors.transparent,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: scaleConfig.scaleHeight(5),
                      right: scaleConfig.scaleHeight(30),
                      top: scaleConfig.scaleHeight(20),
                      bottom: scaleConfig.scaleHeight(20),
                    ),
                    padding: EdgeInsets.only(left: scaleConfig.scaleHeight(20)),
                    decoration: BoxDecoration(
                      color: _colorList[index >= 5 ? index % 5 : index],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Text(
                          _names[index >= 5 ? index % 5 : index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          _prices[index >= 5 ? index % 5 : index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  right: 90,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, widget) {
                      return Transform.rotate(
                        angle: (index == _currentPageIndex)
                            ? _animationController.isAnimating
                                ? rotationAnimation.value
                                : pie * 0.3
                            : _animationController.isAnimating
                                ? rotationAnimation.value + pie * 0.2
                                : pie * 0.15,
                        child: Container(
                          color: Colors.brown,
                          constraints: BoxConstraints(
                              maxHeight: scaleConfig.scaleHeight(180),
                              maxWidth: scaleConfig.scaleHeight(70),
                              minHeight: scaleConfig.scaleHeight(180),
                              minWidth: scaleConfig.scaleHeight(70)),
                          child: Image.asset(
                            images[index >= 3 ? index % 3 : index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
