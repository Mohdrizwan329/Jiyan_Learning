import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class BirdLearningPage extends StatefulWidget {
  const BirdLearningPage({super.key});

  @override
  State<BirdLearningPage> createState() => _BirdLearningPageState();
}

class _BirdLearningPageState extends State<BirdLearningPage> {
  final FlutterTts flutterTts = FlutterTts();

  final List<Map<String, String>> birds = [
    {'name': 'Parrot', 'emoji': '🦜'},
    {'name': 'Peacock', 'emoji': '🦚'},
    {'name': 'Sparrow', 'emoji': '🐦'},
    {'name': 'Crow', 'emoji': '🐦'},
    {'name': 'Eagle', 'emoji': '🦅'},
    {'name': 'Owl', 'emoji': '🦉'},
    {'name': 'Penguin', 'emoji': '🐧'},
    {'name': 'Duck', 'emoji': '🦆'},
    {'name': 'Hen', 'emoji': '🐔'},
    {'name': 'Rooster', 'emoji': '🐓'},
    {'name': 'Pigeon', 'emoji': '🐦'},
    {'name': 'Flamingo', 'emoji': '🦩'},
    {'name': 'Turkey', 'emoji': '🦃'},
    {'name': 'Swan', 'emoji': '🦢'},
    {'name': 'Woodpecker', 'emoji': '🐦'},
    {'name': 'Kingfisher', 'emoji': '🐦'},
    {'name': 'Hawk', 'emoji': '🦅'},
    {'name': 'Canary', 'emoji': '🐦'},
    {'name': 'Crane', 'emoji': '🐦'},
    {'name': 'Stork', 'emoji': '🐦'},
    {'name': 'Hummingbird', 'emoji': '🐦'},
    {'name': 'Quail', 'emoji': '🐦'},
    {'name': 'Magpie', 'emoji': '🐦'},
    {'name': 'Robin', 'emoji': '🐦'},
    {'name': 'Seagull', 'emoji': '🐦'},
    {'name': 'Lark', 'emoji': '🐦'},
    {'name': 'Cuckoo', 'emoji': '🐦'},
    {'name': 'Nightingale', 'emoji': '🐦'},
    {'name': 'Duckling', 'emoji': '🦆'},
    {'name': 'Chick', 'emoji': '🐤'},
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
        backgroundColor: Colors.cyanAccent,
        title: const Text(
          "30 Birds for Kids",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: birds.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final item = birds[index];
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
