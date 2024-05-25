import 'package:flutter/material.dart';
import 'package:diet/screens/splash_scren.dart';

import 'home_screen.dart';

class SplashScren extends StatefulWidget {
  const SplashScren({super.key});

  @override
  State<SplashScren> createState() => _SplashScrenState();
}

class _SplashScrenState extends State<SplashScren>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(context,
          PageRouteBuilder(pageBuilder: (context, a, s) {
        return const HomeScren();
      }), (value) => false);
    });
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.4,
          ),
          Center(
            child: Image.asset(
              'assets/logo.png',
              height: size.height * 0.25,
              width: size.width / 1.5,
            ),
          )
        ],
      ),
    );
  }
}
