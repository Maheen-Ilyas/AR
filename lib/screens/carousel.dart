import 'package:ar/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Carousel> {
  final introKey = GlobalKey<IntroductionScreenState>();
  final pageDecoration = const PageDecoration(
    titleTextStyle: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
    ),
    bodyTextStyle: TextStyle(
      fontSize: 19,
    ),
    bodyPadding: EdgeInsets.all(16),
    pageColor: Colors.white,
    imagePadding: EdgeInsets.zero,
  );

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 5000,
      infiniteAutoScroll: true,
      bodyPadding: const EdgeInsets.all(16),
      globalHeader: const Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: 16,
              right: 16,
            ),
          ),
        ),
      ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: () {
            _onIntroEnd(context);
          },
          child: const Text(
            "Wander Lens",
            style: TextStyle(
              color: Color.fromARGB(255, 32, 53, 96),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Lifestyle & Travel",
          body:
              "Explore Monuments and Historical sites on your mobile phone from the comfort of your homes.",
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Explore AR",
          body:
              "Experience rich and informative view of the World's Most Famous Monuments, at not cost!",
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
      done: const Text(
        'Done',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 32, 53, 96),
        ),
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: Color.fromARGB(255, 32, 53, 96),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
