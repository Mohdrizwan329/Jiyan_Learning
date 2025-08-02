import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:learning_a_to_z/view/Home_Page.dart';
import 'package:learning_a_to_z/view/class/Alphabet_meaning.dart';
import 'package:learning_a_to_z/view/class/Alphbet_Page.dart';
import 'package:learning_a_to_z/view/class/Class_Page.dart';
import 'package:learning_a_to_z/view/class/Table_Count_Page.dart';
import 'package:learning_a_to_z/view/class/Table_Page.dart';
import 'package:learning_a_to_z/view/math/Problems_Pages.dart';
import 'package:learning_a_to_z/view/math/drawing/Drawing_Page.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: "/", page: () => HomeScreen()),
    GetPage(name: "/", page: () => ClassPage()),
    GetPage(name: "/", page: () => AlphabetMening()),
    GetPage(name: "/", page: () => Alphbet26()),
    GetPage(name: "/", page: () => AlphbetSmall26()),

    GetPage(name: "/", page: () => TableScreen()),

    GetPage(name: "/", page: () => TableDetailScreen(number: 7)),
    GetPage(name: "/", page: () => MathGridScreen()),
    GetPage(name: "/", page: () => DrowingScreen()),
  ];
}
