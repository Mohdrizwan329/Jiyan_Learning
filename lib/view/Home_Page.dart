import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:learning_a_to_z/view/PoemApp.dart';
import 'package:learning_a_to_z/view/class/Alphabet_meaning.dart';
import 'package:learning_a_to_z/view/class/Alphbet_Page.dart';
import 'package:learning_a_to_z/view/class/Class_Page.dart';
import 'package:learning_a_to_z/view/class/Table_Page.dart';
import 'package:learning_a_to_z/view/math/Problems_Pages.dart';
import 'package:learning_a_to_z/view/math/drawing/Drawing_Page.dart';
import 'package:learning_a_to_z/view/qustion/Math_Qustions_Page.dart';

class ClassItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget? page;

  ClassItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.page,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ClassItem> classItems = [
    ClassItem(
      title: '1 to 100',
      subtitle: 'Numbers',
      icon: Icons.class_,
      page: ClassPage(),
    ),
    ClassItem(
      title: 'Capital Letters',
      subtitle: 'Alphabets',
      icon: Icons.abc,
      page: Alphbet26(),
    ),
    ClassItem(
      title: 'Small Letters',
      subtitle: 'Alphabets',
      icon: Icons.text_fields,
      page: AlphbetSmall26(),
    ),
    ClassItem(
      title: 'Alphabet',
      subtitle: 'Name',
      icon: Icons.abc_outlined,
      page: AlphabetMening(),
    ),

    ClassItem(
      title: 'Math Problem',
      subtitle: 'Solution',
      icon: Icons.calculate,
      page: MathGridScreen(),
    ),
    ClassItem(
      title: '2 to 40 ',
      subtitle: 'Tables',
      icon: Icons.numbers,
      page: TableScreen(),
    ),
    ClassItem(
      title: 'Drawing Page',
      subtitle: 'Creativity',
      icon: Icons.brush,
      page: DrowingScreen(),
    ),
    ClassItem(
      title: 'Math Questions',
      subtitle: 'Test',
      icon: Icons.question_answer,
      page: MathQustionGridScreen(),
    ),
    ClassItem(
      title: 'Poetry',
      subtitle: 'Test',
      icon: Icons.book,
      page: PoemListPage(),
    ),
    for (int i = 0; i < 4; i++)
      ClassItem(
        title: 'Coming Soon',
        subtitle: '',
        icon: Icons.lock,
        page: null,
      ),
  ];

  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Test Ad ID
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) => setState(() {}),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('Ad failed to load: $error');
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home Page",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 144, 249, 31),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: classItems.length,
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio:
                    (MediaQuery.of(context).size.width / 2.2) / 130,
              ),
              itemBuilder: (context, index) {
                final item = classItems[index];
                return GestureDetector(
                  onTap: () {
                    if (item.page != null) {
                      Get.to(() => item.page!);
                    } else {
                      Get.snackbar(
                        "Coming Soon",
                        "No page available yet for '${item.title}'",
                        backgroundColor: Colors.lightBlueAccent,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  child: Card(
                    elevation: 3,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item.icon, size: 50, color: Colors.green),
                        const SizedBox(height: 10),
                        Text(
                          item.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        if (item.subtitle.isNotEmpty)
                          Text(
                            item.subtitle,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (_bannerAd != null)
            SizedBox(
              height: _bannerAd!.size.height.toDouble(),
              width: _bannerAd!.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
        ],
      ),
    );
  }
}
