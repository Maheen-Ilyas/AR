import 'package:ar/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Carousel> {
  final introKey = GlobalKey<IntroductionScreenState>();
  final pageDecoration = PageDecoration(
    bodyFlex: 2,
    imageFlex: 3,
    pageColor: Colors.white,
    bodyPadding: const EdgeInsets.all(8),
    titleTextStyle: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.lato().toString(),
    ),
    bodyTextStyle: TextStyle(
      fontSize: 20,
      fontFamily: GoogleFonts.lato().toString(),
    ),
  );

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const SignUp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      bodyPadding: const EdgeInsets.all(16),
      globalHeader: Align(
        alignment: Alignment.center,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16,
              right: 16,
            ),
            child: Text(
              "Get Started",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontFamily: GoogleFonts.lato().toString(),
              ),
            ),
          ),
        ),
      ),
      globalFooter: Container(
        width: double.infinity,
        height: 60,
        color: Colors.white,
        child: TextButton(
          onPressed: () {
            _onIntroEnd(context);
          },
          child: Text(
            "Wander Lens",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.lato().toString(),
            ),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Travel",
          image: SvgPicture.asset(
            'assets/travelplans.svg',
            height: 300,
            width: 300,
          ),
          body:
              "Explore monuments and historical sites right from your mobile phone, all within the comfort of your own home.",
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Explore AR",
          image: SvgPicture.asset(
            'assets/ar.svg',
            height: 300,
            width: 300,
          ),
          body:
              "Experience the intricate views of the World's Most Famous Monuments, at not cost!",
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Begin!",
          image: SvgPicture.asset(
            'assets/completed.svg',
            height: 300,
            width: 300,
          ),
          body: "What are you waiting for? Start today!",
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      back: const Icon(Icons.arrow_back),
      next: const Icon(Icons.arrow_forward),
      done: Text(
        'Done',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).primaryColor,
        ),
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      dotsDecorator: DotsDecorator(
        size: const Size(10.0, 10.0),
        color: const Color(0xFFBDBDBD),
        activeColor: Theme.of(context).primaryColor,
        activeSize: const Size(22.0, 10.0),
        activeShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
