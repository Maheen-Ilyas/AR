import 'package:ar/utilities/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ARViewer extends StatefulWidget {
  final String modelPath;
  final String name;
  const ARViewer({
    super.key,
    required this.modelPath,
    required this.name,
  });

  @override
  State<ARViewer> createState() => _ARViewerState();
}

class _ARViewerState extends State<ARViewer> {
  int selectedStoryIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          widget.name,
          style: const TextStyle(
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
