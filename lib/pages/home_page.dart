import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:hooliemusicplayer/services/fetch_songs.dart';
import 'package:hooliemusicplayer/services/my_audio_handler.dart';
import 'package:hooliemusicplayer/widgets/song_widget.dart';

class HomePage extends StatefulWidget {
  final MyAudioHandler audioHandler;
  const HomePage({super.key, required this.audioHandler});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MediaItem> songs = [];
  @override
  void initState() {
    FetchSongs.execute().then((value) {
      setState(() {
        songs = value;
      });

      widget.audioHandler.initSongs(songs: value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hoolie Musics'),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: songs.length,
        itemBuilder: (context, index) {
          MediaItem item = songs[index];
          return SongWidget(
              audioHandler: widget.audioHandler, item: item, index: index);
        },
      ),
    );
  }
}
