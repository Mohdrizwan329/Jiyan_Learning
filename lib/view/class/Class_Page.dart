import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:learning_a_to_z/view/ads/Google_Ads_Page.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({super.key});

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  final FlutterTts flutterTts = FlutterTts();
  final Set<int> selectedIndexes = {};

  Future<void> _speak(String text) async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        await flutterTts.setLanguage("en-IN");

        await flutterTts.setPitch(1.0);
        await flutterTts.speak(text);
      } else {
        print("TTS not supported on this platform.");
      }
    } catch (e) {
      print("TTS Error: $e");
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 243, 243),
      appBar: AppBar(
        title: const Text(
          "Numbers Page",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 144, 249, 31),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 8, right: 20),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 5,
                  bottom: 5,
                  right: 20,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 230, 215, 215),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Counting Numbers 1 to 100",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 100,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final boxNumber = index + 1;
                final isSelected = selectedIndexes.contains(index);

                return GestureDetector(
                  onTap: () {
                    final nextIndex = selectedIndexes.length;

                    if (isSelected) {
                      // Allow only unselecting the last selected number
                      if (index == nextIndex - 1) {
                        setState(() {
                          selectedIndexes.remove(index);
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'You can only unselect number ${nextIndex}',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      }
                    } else {
                      // Allow selecting only the next correct number
                      if (index == nextIndex) {
                        setState(() {
                          selectedIndexes.add(index);
                        });
                        _speak(boxNumber.toString());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please select number ${nextIndex + 1} next',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      }
                    }
                  },
                  child: Card(
                    color: isSelected ? Colors.orange : Colors.white,
                    elevation: 3,
                    child: Center(
                      child: Text(
                        '$boxNumber',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            AdsScreen(),
          ],
        ),
      ),
    );
  }
}
