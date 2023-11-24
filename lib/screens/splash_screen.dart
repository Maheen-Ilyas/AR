import 'package:ar/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:vitality/models/ItemBehaviour.dart';
import 'package:vitality/vitality.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
    return Scaffold(
      body: Center(
        child: Vitality.randomly(
          itemsCount: 80,
          maxSize: 50,
          background: Colors.black12,
          randomItemsBehaviours: [
            ItemBehaviour(
              shape: ShapeType.Icon,
              icon: Icons.landscape,
            ),
            ItemBehaviour(
              shape: ShapeType.Icon,
              icon: Icons.flight_outlined,
            ),
            ItemBehaviour(
              shape: ShapeType.StrokeCircle,
            ),
          ],
          randomItemsColors: const [
            Color.fromARGB(255, 32, 53, 96),
            Colors.white,
          ],
        ),
      ),
    );
  }
}
