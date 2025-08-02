import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Poem {
  final String title;
  final String imageUrl;
  final String audioAsset;
  final String lyrics;

  Poem({
    required this.title,
    required this.imageUrl,
    required this.audioAsset,
    required this.lyrics,
  });
}

class PoemListPage extends StatelessWidget {
  PoemListPage({super.key});

  final List<Poem> poems = [
    Poem(
      title: 'Twinkle Twinkle',
      imageUrl:
          'https://img.freepik.com/free-vector/cute-star-cartoon-character_1308-131499.jpg',
      audioAsset: 'assets/audio/twinkle.mp3',
      lyrics: '''
Twinkle, twinkle, little star,
How I wonder what you are!
Up above the world so high,
Like a diamond in the sky.
''',
    ),
    Poem(
      title: 'Baa Baa Black Sheep',
      imageUrl:
          'https://img.freepik.com/premium-vector/sheep-cartoon-illustration_29190-1195.jpg',
      audioAsset: 'assets/audio/baa.mp3',
      lyrics: '''
Baa, baa, black sheep,
Have you any wool?
Yes sir, yes sir,
Three bags full.
''',
    ),
    Poem(
      title: 'Baa Baa Black Sheep',
      imageUrl:
          'https://img.freepik.com/premium-vector/sheep-cartoon-illustration_29190-1195.jpg',
      audioAsset: 'assets/audio/baa.mp3',
      lyrics: '''
Baa, baa, black sheep,
Have you any wool?
Yes sir, yes sir,
Three bags full.
''',
    ),
    Poem(
      title: 'Baa Baa Black Sheep',
      imageUrl:
          'https://img.freepik.com/premium-vector/sheep-cartoon-illustration_29190-1195.jpg',
      audioAsset: 'assets/audio/baa.mp3',
      lyrics: '''
Baa, baa, black sheep,
Have you any wool?
Yes sir, yes sir,
Three bags full.
''',
    ),
    Poem(
      title: 'Baa Baa Black Sheep',
      imageUrl:
          'https://img.freepik.com/premium-vector/sheep-cartoon-illustration_29190-1195.jpg',
      audioAsset: 'assets/audio/baa.mp3',
      lyrics: '''
Baa, baa, black sheep,
Have you any wool?
Yes sir, yes sir,
Three bags full.
''',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Nursery to Class 2 Poems'),
        backgroundColor: const Color.fromARGB(255, 144, 249, 31),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: poems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final poem = poems[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PoemDetailPage(poem: poem)),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 6,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(poem.imageUrl, width: 60, height: 60),
                  const SizedBox(height: 10),
                  Text(
                    poem.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
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

class PoemDetailPage extends StatefulWidget {
  final Poem poem;

  const PoemDetailPage({super.key, required this.poem});

  @override
  State<PoemDetailPage> createState() => _PoemDetailPageState();
}

class _PoemDetailPageState extends State<PoemDetailPage>
    with SingleTickerProviderStateMixin {
  late final AudioPlayer _audioPlayer;
  late final FlutterTts _flutterTts;
  late final List<String> _poemLines;
  int _highlightedLine = -1;
  double _animationValue = 1.0;

  @override
  void initState() {
    super.initState();
    _poemLines = widget.poem.lyrics.trim().split('\n');
    _audioPlayer = AudioPlayer();
    _flutterTts = FlutterTts();
    _initTts();
    _startPoem();
  }

  Future<void> _initTts() async {
    await _flutterTts.setLanguage("hi-IN");
    await _flutterTts.setSpeechRate(0.15); // 👈 slower
    await _flutterTts.setPitch(1.2);
    await _flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> _startPoem() async {
    _highlightedLine = -1;
    setState(() {
      _animationValue = 1.0;
    });

    await _audioPlayer.stop(); // optional
    await _flutterTts.stop(); // stop previous TTS
    // await _audioPlayer.play(AssetSource(widget.poem.audioAsset)); // optional

    _startHighlightAndSpeak();
  }

  void _startHighlightAndSpeak() async {
    for (int i = 0; i < _poemLines.length; i++) {
      if (!mounted) return;
      setState(() {
        _highlightedLine = i;
      });
      await _flutterTts.speak(_poemLines[i]);
      // Awaiting speak completion is already set in initTts()
    }
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.poem.title),
        backgroundColor: const Color.fromARGB(255, 144, 249, 31),

        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _startPoem),
        ],
      ),
      body: Stack(
        children: [
          // Animated Background Image
          TweenAnimationBuilder<double>(
            tween: Tween(begin: _animationValue, end: 1.1),
            duration: const Duration(seconds: 8),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Image.network(
                  'https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?cs=srgb&dl=pexels-souvenirpixels-414612.jpg&fm=jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              );
            },
          ),

          // Dark Overlay
          Container(color: Colors.black.withOpacity(0.4)),

          // Centered Poem Text
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 400),
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _poemLines.length,
                itemBuilder: (context, index) {
                  final line = _poemLines[index];
                  final isHighlighted = _highlightedLine == index;
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        line,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: isHighlighted
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isHighlighted ? Colors.yellow : Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
