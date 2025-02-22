import 'dart:typed_data';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:hooliemusicplayer/services/fetch_songs.dart';
import 'package:hooliemusicplayer/services/my_audio_handler.dart';
import 'package:transparent_image/transparent_image.dart';

class CoverWidget extends StatelessWidget {
  final MyAudioHandler audioHandler;
  final MediaItem item;

  const CoverWidget(
      {super.key, required this.audioHandler, required this.item});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.width * 0.7,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: item.artUri == null
            ? Icon(Icons.music_note)
            : FutureBuilder<Uint8List?>(
                future: toImage(uri: item.artUri!),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: MemoryImage(snapshot.data!),
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
      ),
    );
  }
}
