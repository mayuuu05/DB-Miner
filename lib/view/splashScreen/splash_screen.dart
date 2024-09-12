import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import '../intro/intro_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedSplashScreen(
        duration:4000,
        splash: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.06),
              Image.asset(
                'assets/images/Screenshot_2024-09-06_120607-removebg-preview.png',
                width: screenWidth * 0.5,
                height: screenHeight * 0.3,
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
              Text(
                'InspireWings',
                style: TextStyle(
                  fontSize: screenWidth * 0.09,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Soar to New Heights',
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        nextScreen: IntroPage(),
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize: screenHeight * 0.5,
        backgroundColor: Colors.transparent,

      ),
    );
  }
}
