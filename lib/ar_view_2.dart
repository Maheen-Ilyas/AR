import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ARViewer extends StatefulWidget {
  final String modelPath;
  const ARViewer({
    super.key,
    required this.modelPath,
  });

  @override
  State<ARViewer> createState() => _ARViewerState();
}

class _ARViewerState extends State<ARViewer> {
  int selectedStoryIndex = 0;
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
          "AR",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: ModelViewer(
        src: widget.modelPath,
        ar: true,
        disableZoom: false,
        cameraControls: true,
      ),
    );
  }
}
