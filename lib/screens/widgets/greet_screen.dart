import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../home_screen.dart';

class GreetScreen extends StatefulWidget {
  const GreetScreen({super.key});

  @override
  State<GreetScreen> createState() => _GreetScreenState();
}

class _GreetScreenState extends State<GreetScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Lottie.network(
        'https://lottie.host/f19793a9-0c7c-4212-94b2-112dbaf66883/Y5IfFTxubf.json',
        repeat: true,
        frameRate: const FrameRate(60),
        fit: BoxFit.contain,
      ),
    );
  }
}
