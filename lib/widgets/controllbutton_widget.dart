import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:hooliemusicplayer/services/my_audio_handler.dart';

class ControllbuttonWidget extends StatelessWidget {
  final MyAudioHandler audioHandler;
  final MediaItem item;

  const ControllbuttonWidget(
      {super.key, required this.audioHandler, required this.item});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlaybackState>(
      stream: audioHandler.playbackState.stream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          bool playing = snapshot.data!.playing;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton.filledTonal(
                onPressed: () {
                  audioHandler.skipToPrevious();
                },
                icon: const Icon(
                  Icons.skip_previous_rounded,
                ),
              ),
              IconButton.filledTonal(
                onPressed: () {
                  if (playing) {
                    audioHandler.pause();
                  } else {
                    audioHandler.play();
                  }
                },
                icon: playing
                    ? const Icon(
                        Icons.pause_rounded,
                        size: 75,
                      )
                    : const Icon(
                        Icons.play_arrow_rounded,
                        size: 75,
                      ),
              ),
              IconButton.filledTonal(
                onPressed: () {
                  audioHandler.skipToNext();
                },
                icon: const Icon(
                  Icons.skip_next_rounded,
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
