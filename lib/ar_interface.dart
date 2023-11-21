import 'package:ar/ar_view_2.dart';
import 'package:ar/utilities/model.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev show log;
import 'package:flutter_blurhash/flutter_blurhash.dart';

class ARInterface extends StatelessWidget {
  final List<ARModel> arModels;
  const ARInterface({
    super.key,
    required this.arModels,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          height: 150,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 32, 53, 96),
                Color.fromARGB(255, 75, 108, 183),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 15,
        centerTitle: true,
        title: const Text(
          "Menu",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: arModels.length,
          itemBuilder: (context, index) {
            ARModel model = arModels[index];
            String imageUrl = model.imageURL;
            dev.log(imageUrl.toString());
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ARViewer(modelPath: model.modelPath),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromARGB(255, 116, 151, 179),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const BlurHash(
                      hash: 'L5H2EC=PM+yV0g-mq.wG9c010J}I',
                      imageFit: BoxFit.cover,
                    ),
                    Image.asset(
                      model.imageURL,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      model.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 31, 29, 29),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
