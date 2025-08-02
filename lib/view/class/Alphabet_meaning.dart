import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:learning_a_to_z/view/ads/Google_Ads_Page.dart';

class AlphabetMening extends StatefulWidget {
  const AlphabetMening({super.key});

  @override
  State<AlphabetMening> createState() => _AlphabetMeningState();
}

class _AlphabetMeningState extends State<AlphabetMening> {
  final FlutterTts flutterTts = FlutterTts();
  final Set<int> selectedIndexes = {};

  final List<Map<String, String>> alphabetData = [
    {'letter': 'A', 'emoji': '🍎', 'meaning': 'Apple'},
    {'letter': 'B', 'emoji': '🐝', 'meaning': 'Bee'},
    {'letter': 'C', 'emoji': '🐈', 'meaning': 'Cat'},
    {'letter': 'D', 'emoji': '🐶', 'meaning': 'Dog'},
    {'letter': 'E', 'emoji': '🐘', 'meaning': 'Elephant'},
    {'letter': 'F', 'emoji': '🐸', 'meaning': 'Frog'},
    {'letter': 'G', 'emoji': '🦒', 'meaning': 'Giraffe'},
    {'letter': 'H', 'emoji': '🏠', 'meaning': 'House'},
    {'letter': 'I', 'emoji': '🍦', 'meaning': 'Ice Cream'},
    {'letter': 'J', 'emoji': '🕹️', 'meaning': 'Joystick'},
    {'letter': 'K', 'emoji': '🦘', 'meaning': 'Kangaroo'},
    {'letter': 'L', 'emoji': '🦁', 'meaning': 'Lion'},
    {'letter': 'M', 'emoji': '🌝', 'meaning': 'Moon'},
    {'letter': 'N', 'emoji': '🥜', 'meaning': 'Nut'},
    {'letter': 'O', 'emoji': '🐙', 'meaning': 'Octopus'},
    {'letter': 'P', 'emoji': '🅿️', 'meaning': 'Parrot'},
    {'letter': 'Q', 'emoji': '👸', 'meaning': 'Queen'},
    {'letter': 'R', 'emoji': '🤖', 'meaning': 'Robot'},
    {'letter': 'S', 'emoji': '🐍', 'meaning': 'Snake'},
    {'letter': 'T', 'emoji': '🐯', 'meaning': 'Tiger'},
    {'letter': 'U', 'emoji': '☂️', 'meaning': 'Umbrella'},
    {'letter': 'V', 'emoji': '🎻', 'meaning': 'Violin'},
    {'letter': 'W', 'emoji': '🌊', 'meaning': 'Water'},
    {'letter': 'X', 'emoji': '❌', 'meaning': 'Xylophone'},
    {'letter': 'Y', 'emoji': '🛶', 'meaning': 'Yacht'},
    {'letter': 'Z', 'emoji': '🦓', 'meaning': 'Zebra'},
  ];

  Future<void> _speak(String text) async {
    try {
      await flutterTts.setLanguage("hi-IND");
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(text);
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
                  "Learn A to Z Alphabet",
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
              itemCount: alphabetData.length,
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final item = alphabetData[index];
                final isSelected = selectedIndexes.contains(index);

                return GestureDetector(
                  onTap: () {
                    final nextIndex = selectedIndexes.length;

                    if (isSelected) {
                      if (index == nextIndex - 1) {
                        setState(() => selectedIndexes.remove(index));
                      } else {
                        _showSnack(
                          "Unselect '${alphabetData[nextIndex - 1]['letter']}' first",
                        );
                      }
                    } else {
                      if (index == nextIndex) {
                        setState(() => selectedIndexes.add(index));
                        _speak("${item['letter']} for ${item['meaning']}");
                      } else {
                        _showSnack(
                          "Tap '${alphabetData[nextIndex]['letter']}' next",
                        );
                      }
                    }
                  },
                  child: Card(
                    color: isSelected ? Colors.orange : Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item['letter']!,
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item['emoji']!,
                          style: const TextStyle(fontSize: 30),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item['meaning']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.green,
      ),
    );
  }
}
