import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FlowerLearningPage extends StatefulWidget {
  const FlowerLearningPage({super.key});

  @override
  State<FlowerLearningPage> createState() => _FlowerLearningPageState();
}

class _FlowerLearningPageState extends State<FlowerLearningPage> {
  final FlutterTts flutterTts = FlutterTts();

  final List<Map<String, String>> flowers = [
    {'name': 'Rose', 'emoji': '🌹'},
    {'name': 'Tulip', 'emoji': '🌷'},
    {'name': 'Sunflower', 'emoji': '🌻'},
    {'name': 'Blossom', 'emoji': '🌸'},
    {'name': 'Hibiscus', 'emoji': '🌺'},
    {'name': 'Lily', 'emoji': '💮'},
    {'name': 'Lotus', 'emoji': '🪷'},
    {'name': 'Daisy', 'emoji': '🌼'},
    {'name': 'Lavender', 'emoji': '💜'},
    {'name': 'Orchid', 'emoji': '🪻'},
    {'name': 'Marigold', 'emoji': '🌼'},
    {'name': 'Jasmine', 'emoji': '🌼'},
    {'name': 'Poppy', 'emoji': '🌺'},
    {'name': 'Peony', 'emoji': '🌸'},
    {'name': 'Daffodil', 'emoji': '🌼'},
    {'name': 'Bluebell', 'emoji': '🔔'},
    {'name': 'Camellia', 'emoji': '🌺'},
    {'name': 'Gardenia', 'emoji': '🌼'},
    {'name': 'Iris', 'emoji': '🌸'},
    {'name': 'Zinnia', 'emoji': '🌺'},
    {'name': 'Petunia', 'emoji': '🌸'},
    {'name': 'Aster', 'emoji': '🌼'},
    {'name': 'Begonia', 'emoji': '🌸'},
    {'name': 'Chrysanthemum', 'emoji': '🌼'},
    {'name': 'Gladiolus', 'emoji': '🌸'},
    {'name': 'Snapdragon', 'emoji': '🌼'},
    {'name': 'Carnation', 'emoji': '🌸'},
    {'name': 'Verbena', 'emoji': '🌺'},
    {'name': 'Cosmos', 'emoji': '🌸'},
    {'name': 'Foxglove', 'emoji': '🔔'},
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
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "30 Flowers for Kids",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: flowers.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final item = flowers[index];
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
