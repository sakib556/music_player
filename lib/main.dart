import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicPlayer(),
    );
  }
}

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  AudioPlayer audioPlayer = AudioPlayer();
  String currentUrl = '';
  bool isPlaying = false;
  bool isLoadingMusic1 = false;
  bool isLoadingMusic2 = false;

  void _playMusic(String url) async {
    if (url ==
        'https://a1.asurahosting.com/listen/boom_tamil_-_toronto/radio.mp3') {
      setState(() {
        isLoadingMusic1 = true;
      });
    } else if (url ==
        'https://demo.azuracast.com/listen/azuratest_radio/radio.mp3') {
      setState(() {
        isLoadingMusic2 = true;
      });
    }

    await audioPlayer.play(UrlSource(url));
    setState(() {
      isPlaying = true;
      currentUrl = url;
      isLoadingMusic1 = false;
      isLoadingMusic2 = false;
    });
  }

  void _pauseMusic() async {
    await audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Player'),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          const SizedBox(
            height: 20,
          ),
          _buildMusicButton(
            'Play Music 1',
            'https://a1.asurahosting.com/listen/boom_tamil_-_toronto/radio.mp3',
            Icons.music_note,
            isLoadingMusic1,
          ),
          const SizedBox(height: 10),
          _buildMusicButton(
            'Play Music 2',
            'https://demo.azuracast.com/listen/azuratest_radio/radio.mp3',
            Icons.music_note,
            isLoadingMusic2,
          ),
        ],
      ),
    );
  }

  Widget _buildMusicButton(
    String buttonText,
    String url,
    IconData iconData,
    bool isLoading,
  ) {
    return ElevatedButton(
      onPressed: isLoading ? null : () => _onMusicButtonPressed(url),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData),
          const SizedBox(width: 8),
          isLoading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                )
              : Text(
                  isPlaying && currentUrl == url ? 'Pause Music' : buttonText,
                ),
        ],
      ),
    );
  }

  void _onMusicButtonPressed(String url) {
    if (isPlaying && currentUrl == url) {
      _pauseMusic();
    } else {
      _playMusic(url);
    }
  }
}
