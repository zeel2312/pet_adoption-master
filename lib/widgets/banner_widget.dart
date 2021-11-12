import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .25,
          color: Colors.cyan,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'DOGS',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 45.0,
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                              child: AnimatedTextKit(
                                repeatForever: true,
                                isRepeatingAnimation: true,
                                animatedTexts: [
                                  FadeAnimatedText('I Love Dogs',
                                    duration: Duration(seconds: 4),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Neumorphic(
                        style: NeumorphicStyle(
                          color: Colors.white,
                          oppositeShadowLightSource: true
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network('https://firebasestorage.googleapis.com/v0/b/fir-pet-adoption.appspot.com/o/banner%2Ficons8-dog-100.png?alt=media&token=28725f4b-ed76-45a9-aec1-4658a47320be'),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: NeumorphicButton(
                      onPressed: (){},
                      style: NeumorphicStyle(color: Colors.white),
                      child: Text('Adopt Dog',textAlign: TextAlign.center,),
                    ),),
                    SizedBox(width: 20,),
                    Expanded(child: NeumorphicButton(
                      onPressed: (){},
                      style: NeumorphicStyle(color: Colors.white),
                      child: Text('Shelter Dog',textAlign: TextAlign.center,),
                    ),),
                  ],
                ),
              ],
            ),
          ),
      ),
    );
  }
}
