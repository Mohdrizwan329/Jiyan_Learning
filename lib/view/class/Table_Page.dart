import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/route_manager.dart';
import 'package:learning_a_to_z/view/Home_Page.dart';
import 'package:learning_a_to_z/view/ads/Google_Ads_Page.dart';
import 'package:learning_a_to_z/view/class/Table_Count_Page.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  final FlutterTts flutterTts = FlutterTts();
  final Set<int> expandedIndexes = {};

  final List<String> hindiMultipliers = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
  ];

  Future<void> _speakPahada(int number) async {
    String pahada = "";
    for (int i = 1; i <= 10; i++) {
      pahada += "$number ${hindiMultipliers[i - 1]} ${number * i}, ";
    }

    try {
      if (Platform.isAndroid || Platform.isIOS) {
        await flutterTts.setLanguage("hi-IN");
        await flutterTts.setPitch(1.0);
        await flutterTts.setSpeechRate(0.5);
        await flutterTts.speak(pahada);
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
    final totalBoxes = 39; // 2 to 20

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 243, 243),
      appBar: AppBar(
        title: const Text(
          "Table Page",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.offAll(() => HomeScreen());
          },
        ),
        backgroundColor: const Color.fromARGB(255, 144, 249, 31),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
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
                  "Table 2 To 40",
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
              itemCount: totalBoxes,
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // use 2 for enough space
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) {
                final number = index + 2;
                final isExpanded = expandedIndexes.contains(index);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isExpanded) {
                        expandedIndexes.remove(index);
                      } else {
                        expandedIndexes.add(index);
                        _speakPahada(number);
                      }
                    });
                    Get.offAll(() => TableDetailScreen(number: number));
                  },
                  child: Card(
                    elevation: 4,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: isExpanded
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '$number',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                          // if (isExpanded) const SizedBox(height: 8),
                          // if (isExpanded)
                        ],
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
