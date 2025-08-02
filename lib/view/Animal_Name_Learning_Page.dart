import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AnimalLearningPage extends StatefulWidget {
  const AnimalLearningPage({super.key});

  @override
  State<AnimalLearningPage> createState() => _AnimalLearningPageState();
}

class _AnimalLearningPageState extends State<AnimalLearningPage> {
  final FlutterTts flutterTts = FlutterTts();

  final List<Map<String, String>> animals = [
    {'name': 'Dog', 'emoji': '🐶'},
    {'name': 'Cat', 'emoji': '🐱'},
    {'name': 'Lion', 'emoji': '🦁'},
    {'name': 'Tiger', 'emoji': '🐯'},
    {'name': 'Elephant', 'emoji': '🐘'},
    {'name': 'Monkey', 'emoji': '🐵'},
    {'name': 'Cow', 'emoji': '🐄'},
    {'name': 'Horse', 'emoji': '🐴'},
    {'name': 'Goat', 'emoji': '🐐'},
    {'name': 'Sheep', 'emoji': '🐑'},
    {'name': 'Pig', 'emoji': '🐷'},
    {'name': 'Rabbit', 'emoji': '🐰'},
    {'name': 'Bear', 'emoji': '🐻'},
    {'name': 'Fox', 'emoji': '🦊'},
    {'name': 'Wolf', 'emoji': '🐺'},
    {'name': 'Kangaroo', 'emoji': '🦘'},
    {'name': 'Zebra', 'emoji': '🦓'},
    {'name': 'Giraffe', 'emoji': '🦒'},
    {'name': 'Panda', 'emoji': '🐼'},
    {'name': 'Camel', 'emoji': '🐫'},
    {'name': 'Deer', 'emoji': '🦌'},
    {'name': 'Crocodile', 'emoji': '🐊'},
    {'name': 'Hippopotamus', 'emoji': '🦛'},
    {'name': 'Rhinoceros', 'emoji': '🦏'},
    {'name': 'Bat', 'emoji': '🦇'},
    {'name': 'Squirrel', 'emoji': '🐿️'},
    {'name': 'Otter', 'emoji': '🦦'},
    {'name': 'Mouse', 'emoji': '🐭'},
    {'name': 'Frog', 'emoji': '🐸'},
    {'name': 'Duck', 'emoji': '🦆'},
  ];

  Future<void> _speak(String text) async {
    try {
      await flutterTts.setLanguage("en-IN");
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
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text(
          "30 Animals for Kids",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: animals.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final item = animals[index];
          return GestureDetector(
            onTap: () => _speak(item['name']!),
            child: Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(item['emoji']!, style: const TextStyle(fontSize: 40)),
                  const SizedBox(height: 10),
                  Text(
                    item['name']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
