import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: SubtractionQuestionsScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class QuestionModel {
  final int num1;
  final int num2;
  final TextEditingController controller;
  String result;
  bool isAnswered;

  QuestionModel(this.num1, this.num2)
    : controller = TextEditingController(),
      result = '',
      isAnswered = false;
}

class SubtractionQuestionsScreen extends StatefulWidget {
  const SubtractionQuestionsScreen({super.key});

  @override
  State<SubtractionQuestionsScreen> createState() =>
      _SubtractionQuestionsScreenState();
}

class _SubtractionQuestionsScreenState
    extends State<SubtractionQuestionsScreen> {
  final List<QuestionModel> _questions = List.generate(50, (_) {
    final rand = Random();
    int a = rand.nextInt(90) + 10; // 10–99
    int b = rand.nextInt(90) + 10;
    int num1 = max(a, b);
    int num2 = min(a, b);
    return QuestionModel(num1, num2);
  });

  int _currentBatch = 0;
  int correct = 0;
  int incorrect = 0;

  int get _startIndex => _currentBatch * 10;
  int get _endIndex => min(_startIndex + 10, _questions.length);

  bool _isInCurrentBatch(int index) {
    return index >= _startIndex && index < _endIndex;
  }

  void _checkAnswer(int index) {
    final question = _questions[index];
    final userAnswer = int.tryParse(question.controller.text.trim());
    final correctAnswer = question.num1 - question.num2;

    if (userAnswer != null) {
      if (userAnswer == correctAnswer) {
        correct++;
      } else {
        incorrect++;
      }

      setState(() {
        question.result =
            "Your Answer: $userAnswer\nCorrect Answer: $correctAnswer";
        question.isAnswered = true;
      });

      final allAnswered = _questions
          .sublist(_startIndex, _endIndex)
          .every((q) => q.isAnswered);

      if (allAnswered) {
        _showScoreDialog();
      }
    }
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Batch Completed!"),
        content: Text("Correct: $correct\nIncorrect: $incorrect"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _moveToNextBatch();
            },
            child: const Text("Next 10 Questions"),
          ),
        ],
      ),
    );
  }

  void _moveToNextBatch() {
    setState(() {
      _currentBatch++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subtraction Questions (10 at a time)'),
        backgroundColor: Colors.pink.shade300,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _questions.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 240,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final question = _questions[index];

          if (!_isInCurrentBatch(index) && !question.isAnswered) {
            return Card(
              color: Colors.grey.shade200,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock, color: Colors.grey, size: 30),
                    SizedBox(height: 5),
                    Text("Locked", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            );
          }

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          " − ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          children: [
                            Text(
                              "${question.num1}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "${question.num2}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (!question.isAnswered)
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: question.controller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Your Ans",
                          ),
                        ),
                      ),
                    if (question.isAnswered)
                      Text(
                        question.result,
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(height: 10),
                    if (!question.isAnswered)
                      ElevatedButton(
                        onPressed: () => _checkAnswer(index),
                        child: const Text("Submit"),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
