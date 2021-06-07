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
  final double degree = 3.14 / 180;
  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: _currentPageIndex, viewportFraction: 0.83);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    rotationAnimation = Tween<double>(begin: -degree * 60, end: -degree * 30)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeOut));
  }

  List<Color> _colorList = [
    Colors.deepOrange.shade400,
    Colors.orangeAccent.shade200,
    Colors.indigoAccent.shade100,
    Colors.tealAccent.shade700,
    Colors.blueAccent.shade100,
  ];
  List<String> _names = [
    "Air Max 97",
    "Appha Savage",
    "KD23 FP",
    "FD15 EP",
    "KD13 RP",
  ];
  List<String> _prices = [
    "Rs 11,897",
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
      height: SizeScaleConfig.screenHeight * 0.43,
      width: SizeScaleConfig.screenWidth,
      child: PageView.builder(
        clipBehavior: Clip.antiAliasWithSaveLayer,
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
              right: 25,
            ),
            // color: Colors.grey,
            color: Colors.transparent,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    margin: EdgeInsets.only(
                      right: scaleConfig.scaleHeight(40),
                      top: scaleConfig.scaleHeight(35),
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
                            color:
                                index % 2 == 0 ? Colors.white : Colors.black87,
                            fontSize: 23,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          _prices[index >= 5 ? index % 5 : index],
                          style: TextStyle(
                            color: index % 2 == 0
                                ? Colors.white70
                                : Colors.black45,
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  right: -25,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, widget) {
                      return Transform.rotate(
                        angle: (index == _currentPageIndex)
                            ? _animationController.isAnimating
                                ? rotationAnimation.value
                                : -degree * 30
                            : _animationController.isAnimating
                                ? (rotationAnimation.value + degree * 30)
                                : -degree * 60,
                        child: Container(
                          color: Colors.transparent,
                          height: 184,
                          width: 320,
                          child: Image.asset(
                            images[index >= 3 ? index % 3 : index],
                            fit: BoxFit.fitWidth,
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
