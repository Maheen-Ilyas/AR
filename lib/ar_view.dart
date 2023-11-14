import 'package:ar/utilities/animated_button.dart';
import 'package:ar/utilities/mode_and_story.dart';
import 'package:ar/utilities/model.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class AR extends StatefulWidget {
  const AR({super.key});

  @override
  State<AR> createState() => _ARState();
}

class _ARState extends State<AR> {
  int storyStep = 0;
  List<bool> buttonVisibilities = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  // Position of buttons
  final List<Offset> buttonPositions = const [
    Offset(0.1, 0.1),
    Offset(0.8, 0.2),
    Offset(0.2, 0.8),
    Offset(0.8, 0.5),
    Offset(0.5, 0.8),
    Offset(0.4, 0.6),
    Offset(0.6, 0.4),
    Offset(0.5, 0.9),
    Offset(0.9, 0.5),
    Offset(0.5, 0.3),
  ];

  int selectedModelIndex = 0;
  
  void showStoryBox(BuildContext context, String story) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Story'),
          content: Text(
            story,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontStyle: FontStyle.italic,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (storyStep < buttonVisibilities.length - 1) {
                  setState(
                    () {
                      buttonVisibilities[storyStep + 1] = true;
                    },
                  );
                }
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    updateButtonVisibility();
  }

  void updateButtonVisibility() {
    buttonVisibilities = List.generate(
      models[selectedModelIndex].story.length,
      (index) => index == storyStep,
    );
  }

  @override
  Widget build(BuildContext context) {
    ARModel selectedModel = models[selectedModelIndex];

    return MaterialApp(
      home: Scaffold(
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
                  Color.fromARGB(255, 24, 40, 72),
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
          title: Text(
            models[selectedModelIndex].name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(
              children: [
                Positioned(
                  left: 20,
                  bottom: -10,
                  child: DropdownButton<String>(
                    value: selectedModel.name.toString(),
                    items: models.map(
                      (ARModel model) {
                        return DropdownMenuItem<String>(
                          value: model.name.toString(),
                          child: Text(model.name),
                        );
                      },
                    ).toList(),
                    onChanged: (String? modelName) {
                      int index = models.indexWhere(
                        (model) => model.name == modelName,
                      );
                      if (index >= 0 && index < models.length) {
                        setState(() {
                          selectedModelIndex = index;
                          storyStep = 0;
                          updateButtonVisibility();
                        });
                      }
                    },
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    dropdownColor: Colors.grey[200],
                    elevation: 5,
                    icon: const Icon(Icons.arrow_drop_down),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(
                    height: 500,
                    width: 500,
                    child: ModelViewer(
                      src: selectedModel.modelPath,
                      ar: true,
                      disableZoom: false,
                    ),
                  ),
                ),
                for (int i = 0; i < buttonVisibilities.length; i++)
                  Visibility(
                    visible: buttonVisibilities[i],
                    child: Positioned(
                      left: buttonPositions[i].dx *
                          MediaQuery.of(context).size.width,
                      top: buttonPositions[i].dy *
                          MediaQuery.of(context).size.height,
                      child: AnimatedButton(
                        onPressed: () {
                          showStoryBox(
                            context,
                            selectedModel.story[storyStep],
                          );
                          setState(
                            () {
                              buttonVisibilities[i] = false;
                              if (storyStep + 1 < buttonVisibilities.length) {
                                buttonVisibilities[storyStep + 1] = true;
                              }
                              if (storyStep < selectedModel.story.length - 1) {
                                storyStep++;
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
