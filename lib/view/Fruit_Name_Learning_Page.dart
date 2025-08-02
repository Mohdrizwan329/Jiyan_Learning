import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FruitLearningPage extends StatefulWidget {
  const FruitLearningPage({super.key});

  @override
  State<FruitLearningPage> createState() => _FruitLearningPageState();
}

class _FruitLearningPageState extends State<FruitLearningPage> {
  final FlutterTts flutterTts = FlutterTts();

  final List<Map<String, String>> fruits = [
    {'name': 'Apple', 'emoji': '🍎'},
    {'name': 'Banana', 'emoji': '🍌'},
    {'name': 'Grapes', 'emoji': '🍇'},
    {'name': 'Watermelon', 'emoji': '🍉'},
    {'name': 'Cherry', 'emoji': '🍒'},
    {'name': 'Peach', 'emoji': '🍑'},
    {'name': 'Pineapple', 'emoji': '🍍'},
    {'name': 'Mango', 'emoji': '🥭'},
    {'name': 'Orange', 'emoji': '🍊'},
    {'name': 'Lemon', 'emoji': '🍋'},
    {'name': 'Pear', 'emoji': '🍐'},
    {'name': 'Kiwi', 'emoji': '🥝'},
    {'name': 'Melon', 'emoji': '🍈'},
    {'name': 'Green Apple', 'emoji': '🍏'},
    {'name': 'Coconut', 'emoji': '🥥'},
    {'name': 'Strawberry', 'emoji': '🍓'},
    {'name': 'Blueberry', 'emoji': '🫐'},
    {'name': 'Avocado', 'emoji': '🥑'},
    {'name': 'Papaya', 'emoji': '🥭'},
    {'name': 'Fig', 'emoji': '🍈'},
    {'name': 'Guava', 'emoji': '🍏'},
    {'name': 'Lychee', 'emoji': '🍒'},
    {'name': 'Plum', 'emoji': '🍑'},
    {'name': 'Jackfruit', 'emoji': '🍈'},
    {'name': 'Tamarind', 'emoji': '🥥'},
    {'name': 'Pomegranate', 'emoji': '🍎'},
    {'name': 'Date', 'emoji': '🥥'},
    {'name': 'Mulberry', 'emoji': '🫐'},
    {'name': 'Raspberry', 'emoji': '🍓'},
    {'name': 'Starfruit', 'emoji': '⭐'},
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
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text(
          "30 Fruits for Kids",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: fruits.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final item = fruits[index];
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
