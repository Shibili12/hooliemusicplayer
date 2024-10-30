import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:hooliemusicplayer/services/my_audio_handler.dart';
import 'package:hooliemusicplayer/widgets/controllbutton_widget.dart';
import 'package:hooliemusicplayer/widgets/cover_widget.dart';
import 'package:hooliemusicplayer/widgets/progress_bar_widget.dart';

class PlayerPage extends StatefulWidget {
  final MyAudioHandler audioHandler;

  const PlayerPage({super.key, required this.audioHandler});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hoolie Player"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: StreamBuilder<MediaItem?>(
          stream: widget.audioHandler.mediaItem,
          builder: (context, mediasnapshot) {
            if (mediasnapshot.data != null) {
              MediaItem item = mediasnapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CoverWidget(audioHandler: widget.audioHandler, item: item),
                  Column(
                    children: [
                      Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        item.artist!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  ProgressBarWidget(
                      audioHandler: widget.audioHandler, item: item),
                  ControllbuttonWidget(
                      audioHandler: widget.audioHandler, item: item),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
