import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';

import 'greet_screen.dart';
import 'main_screen.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        enableSideReveal: false,
        waveType: WaveType.liquidReveal,
        positionSlideIcon: 0.9,
        pages: const [
          GreetScreen(),
          MainScreen(),
        ],
      ),
    );
  }
}
