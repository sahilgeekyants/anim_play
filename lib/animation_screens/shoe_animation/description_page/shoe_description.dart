import 'package:anim_play/utils/scale_config.dart';
import 'package:flutter/material.dart';
import '../shoe_assets.dart';
import 'description_page_hero.dart';

class ShoeDescription extends StatefulWidget {
  final int index;
  ShoeDescription({@required this.index});
  @override
  _ShoeDescriptionState createState() => _ShoeDescriptionState();
}

class _ShoeDescriptionState extends State<ShoeDescription> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: SizeScaleConfig.screenWidth,
          height: SizeScaleConfig.screenHeight,
          color: Colors.white,
        ),
        //use ClipOval or customPainter
        // ClipOval(
        //   // clipper: ,
        //   child: Column(
        //     children: [
        //       //
        //     ],
        //   ),
        // ),
        Container(
          width: double.infinity,
          height: SizeScaleConfig.screenHeight * 0.4,
          decoration: BoxDecoration(
            color: ShoeAssets
                .colorList[widget.index >= 5 ? widget.index % 5 : widget.index],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(SizeScaleConfig.screenWidth * 0.7,
                  SizeScaleConfig.screenWidth * 0.5),
              bottomRight: Radius.elliptical(SizeScaleConfig.screenWidth * 0.6,
                  SizeScaleConfig.screenWidth * 0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DescriptionPageHero(
                tag: 'shoe' + widget.index.toString(),
                child: Container(
                  color: Colors.transparent,
                  // color: Colors.grey,
                  height: 184,
                  width: 320,
                  child: Image.asset(
                    ShoeAssets.images[
                        widget.index >= 3 ? widget.index % 3 : widget.index],
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ],
          ),
        ),
        //
        Scaffold(
          backgroundColor: Colors.transparent, //for BG image
          appBar: AppBar(
            elevation: 0, //for BG image
            backgroundColor: Colors.transparent, //for BG image
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              iconSize: 30,
              color: Colors.white,
              icon: Icon(Icons.arrow_back),
            ),
            actions: [
              Icon(
                Icons.favorite_border_outlined,
                color: Colors.white,
                size: 30,
              ),
              SizedBox(width: 10),
            ],
          ),
          // body: ,
        ),
      ],
    );
  }
}
