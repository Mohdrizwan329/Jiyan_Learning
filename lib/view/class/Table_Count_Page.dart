import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:learning_a_to_z/view/class/Table_Page.dart';

class TableDetailScreen extends StatefulWidget {
  final int number;

  const TableDetailScreen({super.key, required this.number});

  @override
  State<TableDetailScreen> createState() => _TableDetailScreenState();
}

class _TableDetailScreenState extends State<TableDetailScreen> {
  final FlutterTts flutterTts = FlutterTts();
  int currentStep = 0; // only this index is allowed to click

  Future<void> _speak(String text) async {
    try {
      await flutterTts.setLanguage("en-IN");
      await flutterTts.setPitch(1.0);
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.speak(text);
    } catch (e) {
      print("TTS Error: $e");
    }
  }

  void _onBoxTap(int index) {
    if (index != currentStep) return; // only current allowed

    final number = widget.number;
    final multiplier = index + 1;
    final product = number * multiplier;
    final line = "$number multiply $multiplier = $product";

    _speak(line);

    setState(() {
      currentStep++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final number = widget.number;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 243, 243),

      appBar: AppBar(
        title: Text(
          "$number का पहाड़ा",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 144, 249, 31),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.offAll(() => TableScreen());
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                currentStep = 0;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: 10,
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.4,
          ),
          itemBuilder: (context, i) {
            final product = number * (i + 1);

            Color boxColor;
            if (i == currentStep) {
              boxColor = Colors.lightGreenAccent; // current active box
            } else if (i < currentStep) {
              boxColor = Colors.orangeAccent; // already clicked
            } else {
              boxColor = Colors.grey.shade300; // not clickable yet
            }

            return GestureDetector(
              onTap: () => _onBoxTap(i),
              child: Card(
                elevation: 4,
                color: boxColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "$number × ${i + 1} = $product",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: i <= currentStep ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
