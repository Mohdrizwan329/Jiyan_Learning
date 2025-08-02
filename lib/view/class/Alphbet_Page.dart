import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:learning_a_to_z/view/ads/Google_Ads_Page.dart';

class Alphbet26 extends StatefulWidget {
  const Alphbet26({super.key});

  @override
  State<Alphbet26> createState() => _Alphbet26State();
}

class _Alphbet26State extends State<Alphbet26> {
  final FlutterTts flutterTts = FlutterTts();
  final Set<int> selectedIndexes = {};

  // A to Z list
  final List<String> alphabets = List.generate(
    26,
    (index) => String.fromCharCode(65 + index),
  ); // A-Z

  Future<void> _speak(String text) async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        await flutterTts.setLanguage("en-IND");
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
          "Alphabet Learning (A to Z)",
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
                  "Learn A to Z Capital letter",
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
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: alphabets.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final letter = alphabets[index];
                final isSelected = selectedIndexes.contains(index);

                return GestureDetector(
                  onTap: () {
                    final nextIndex = selectedIndexes.length;

                    if (isSelected) {
                      if (index == nextIndex - 1) {
                        setState(() {
                          selectedIndexes.remove(index);
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'You can only unselect letter ${alphabets[nextIndex - 1]}',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      }
                    } else {
                      if (index == nextIndex) {
                        setState(() {
                          selectedIndexes.add(index);
                        });
                        _speak(letter);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please select letter ${alphabets[nextIndex]} next',
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
                        letter,
                        style: const TextStyle(
                          fontSize: 40,
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

class AlphbetSmall26 extends StatefulWidget {
  const AlphbetSmall26({super.key});

  @override
  State<AlphbetSmall26> createState() => _AlphbetSmall26State();
}

class _AlphbetSmall26State extends State<AlphbetSmall26> {
  final FlutterTts flutterTts = FlutterTts();
  final Set<int> selectedIndexes = {};

  // A to Z list
  final List<String> alphabets = List.generate(
    26,
    (index) => String.fromCharCode(97 + index),
  ); // A-Z

  Future<void> _speak(String text) async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        await flutterTts.setLanguage("en-IND");
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
          "Alphabet Page",
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
                  "Learn a to z Small letter",
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
              physics: NeverScrollableScrollPhysics(),
              itemCount: alphabets.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final letter = alphabets[index];
                final isSelected = selectedIndexes.contains(index);

                return GestureDetector(
                  onTap: () {
                    final nextIndex = selectedIndexes.length;

                    if (isSelected) {
                      if (index == nextIndex - 1) {
                        setState(() {
                          selectedIndexes.remove(index);
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'You can only unselect letter ${alphabets[nextIndex - 1]}',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      }
                    } else {
                      if (index == nextIndex) {
                        setState(() {
                          selectedIndexes.add(index);
                        });
                        _speak(letter);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please select letter ${alphabets[nextIndex]} next',
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
                        letter,
                        style: const TextStyle(
                          fontSize: 40,
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
