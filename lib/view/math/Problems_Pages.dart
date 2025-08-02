import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:learning_a_to_z/view/Home_Page.dart';
import 'package:learning_a_to_z/view/ads/Google_Ads_Page.dart';

class MathGridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Math Practice'),
        backgroundColor: const Color.fromARGB(255, 144, 249, 31),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.offAll(() => HomeScreen());
          },
        ),
      ),
      body: Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            padding: const EdgeInsets.all(16),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildBox(
                'Addition',
                Icons.add,
                Colors.blue,
                () => Get.to(() => AdditionPage()),
              ),
              _buildBox(
                'Subtraction',
                Icons.remove,
                Colors.red,
                () => Get.to(() => SubtractionPage()),
              ),
              _buildBox(
                'Multiplication',
                Icons.clear,
                Colors.orange,
                () => Get.to(() => MultiplicationPage()),
              ),
              _buildBox(
                'Division',
                Icons.percent,
                Colors.purple,
                () => Get.to(() => DivisionPage()),
              ),
            ],
          ),
          AdsScreen(),
        ],
      ),
    );
  }

  Widget _buildBox(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 4,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: color),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MathGridTemplate extends StatefulWidget {
  final String title;
  final String operator;

  const MathGridTemplate({
    Key? key,
    required this.title,
    required this.operator,
  }) : super(key: key);

  @override
  State<MathGridTemplate> createState() => _MathGridTemplateState();
}

class _MathGridTemplateState extends State<MathGridTemplate> {
  final Random _random = Random();
  final FlutterTts flutterTts = FlutterTts();
  List<String> problems = [];
  Set<int> selectedIndices = {};

  @override
  void initState() {
    super.initState();
    generateProblems();
  }

  void generateProblems() {
    problems = List.generate(90, (index) {
      int a = _random.nextInt(10) + 1;
      int b = _random.nextInt(10) + 1;

      if (widget.operator == '-') {
        if (a < b) {
          int temp = a;
          a = b;
          b = temp;
        }
      } else if (widget.operator == '÷') {
        b = _random.nextInt(9) + 1; // avoid division by zero
        a = b * (_random.nextInt(10) + 1); // ensure clean division
        return "$a ÷ $b = ${a ~/ b}";
      }

      if (widget.operator == '×') {
        return "$a × $b = ${a * b}";
      } else if (widget.operator == '+') {
        return "$a + $b = ${a + b}";
      } else if (widget.operator == '-') {
        return "$a - $b = ${a - b}";
      } else {
        return "$a * $b = ${a * b}";
      }
    });
  }

  void _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text.replaceAll('×', 'times'));
  }

  void _toggleSelection(int index) {
    setState(() {
      if (selectedIndices.contains(index)) {
        selectedIndices.remove(index);
      } else {
        selectedIndices.add(index);
        _speak(problems[index]);
      }
    });
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color getTileColor(int index) =>
        selectedIndices.contains(index) ? Colors.orange : Colors.white!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color.fromARGB(255, 144, 249, 31),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.offAll(() => MathGridScreen()),
        ),
      ),
      body: GridView.builder(
        itemCount: problems.length,
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.5,
        ),
        itemBuilder: (context, index) {
          final question = problems[index];
          return GestureDetector(
            onTap: () => _toggleSelection(index),
            child: Card(
              color: getTileColor(index),
              elevation: 4,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    question,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Separate Pages
class AdditionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MathGridTemplate(title: "Addition", operator: '+');
  }
}

class SubtractionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MathGridTemplate(title: "Subtraction", operator: '-');
  }
}

class MultiplicationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MathGridTemplate(title: "Multiplication", operator: '×');
  }
}

class DivisionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MathGridTemplate(title: "Division", operator: '÷');
  }
}
