import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:learning_a_to_z/view/Home_Page.dart';
import 'package:learning_a_to_z/view/ads/Google_Ads_Page.dart';
import 'package:learning_a_to_z/view/qustion/Add_Qst_Page.dart';
import 'package:learning_a_to_z/view/qustion/Div_Qst_Page.dart';
import 'package:learning_a_to_z/view/qustion/Mul_Qst_Page.dart';
import 'package:learning_a_to_z/view/qustion/Sub_Qst_Page.dart';

class MathQustionGridScreen extends StatelessWidget {
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
                () => Get.to(() => AdditionQuestionsScreen()),
              ),
              _buildBox(
                'Subtraction',
                Icons.remove,
                Colors.red,
                () => Get.to(() => SubtractionQuestionsScreen()),
              ),
              _buildBox(
                'Multiplication',
                Icons.clear,
                Colors.orange,
                () => Get.to(() => MultiplicationQuestionsScreen()),
              ),
              _buildBox(
                'Division',
                Icons.percent,
                Colors.purple,
                () => Get.to(() => DivisionQuestionsScreen()),
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
