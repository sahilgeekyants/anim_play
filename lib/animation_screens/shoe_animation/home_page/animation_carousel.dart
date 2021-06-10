import 'package:anim_play/animation_screens/shoe_animation/description_page/shoe_description.dart';
import 'package:anim_play/animation_screens/shoe_animation/shoe_assets.dart';
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

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  final SizeScaleConfig scaleConfig = SizeScaleConfig();

  @override
  Widget build(BuildContext context) {
    Widget heroFlightshuttleBuilder(
      BuildContext flightContext,
      Animation<double> animation,
      HeroFlightDirection direction,
      BuildContext fromContext,
      BuildContext toContext,
      int index,
    ) {
      // HeroFlightDirection.pop
      print('Hero animation status:${animation.status}');
      final Hero toHero = toContext.widget;
      return RotationTransition(
        turns: animation.drive(
          Tween(begin: -0.1, end: 0),
        ),
        child: toHero.child,
      );
    }

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
                //Card
                Positioned.fill(
                  child: Container(
                    margin: EdgeInsets.only(
                      right: scaleConfig.scaleHeight(40),
                      top: scaleConfig.scaleHeight(35),
                      bottom: scaleConfig.scaleHeight(20),
                    ),
                    padding: EdgeInsets.only(left: scaleConfig.scaleHeight(21)),
                    decoration: BoxDecoration(
                      color:
                          ShoeAssets.colorList[index >= 5 ? index % 5 : index],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Text(
                          ShoeAssets.names[index >= 5 ? index % 5 : index],
                          style: TextStyle(
                            color:
                                index % 2 == 0 ? Colors.white : Colors.black87,
                            fontSize: 23,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          ShoeAssets.prices[index >= 5 ? index % 5 : index],
                          style: TextStyle(
                            color: index % 2 == 0
                                ? Colors.white70
                                : Colors.black45,
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: Container(
                            width: 1.5,
                            height: 150,
                            color: index % 2 == 0
                                ? Colors.white30
                                : Colors.black12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //shoe
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
                          child: Hero(
                            tag: 'shoe' + index.toString(),
                            transitionOnUserGestures: true,
                            // createRectTween: (begin, end) {
                            //   return RectTween(
                            //     // begin: Rect.fromCenter(
                            //     //   center: begin.center,
                            //     //   width: begin.width,
                            //     //   height: begin.height,
                            //     // ),
                            //     // end: Rect.fromPoints(
                            //     //   // Offset(300, 700),
                            //     //   // Offset(400, 300),
                            //     //   Offset(500, 500),
                            //     //   Offset(0, 0),
                            //     // ),
                            //     begin: Rect.fromCircle(
                            //         center: begin.center, radius: radius),
                            //     end: Rect.fromCenter(
                            //       center: end.center,
                            //       width: end.width,
                            //       height: end.height,
                            //     ),
                            //   );
                            // },
                            flightShuttleBuilder: (flightContext, animation,
                                direction, fromContext, toContext) {
                              return heroFlightshuttleBuilder(
                                flightContext,
                                animation,
                                direction,
                                fromContext,
                                toContext,
                                index,
                              );
                            },
                            child: Builder(
                              builder: (context) {
                                return GestureDetector(
                                  onTap: () {
                                    print(
                                        'Going to detial screen with index : $index');
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ShoeDescription(index: index)));
                                  },
                                  child: Image.asset(
                                    ShoeAssets
                                        .images[index >= 3 ? index % 3 : index],
                                    fit: BoxFit.fitWidth,
                                  ),
                                );
                              },
                            ),
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
