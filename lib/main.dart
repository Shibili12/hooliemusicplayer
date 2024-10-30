import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hooliemusicplayer/pages/home_page.dart';
import 'package:hooliemusicplayer/services/my_audio_handler.dart';

MyAudioHandler _audioHandler = MyAudioHandler();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _audioHandler = await AudioService.init(
    builder: ()=> MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.example.hooliemusicplayer',
      androidNotificationChannelName: 'Audio Playback',
      androidNotificationOngoing: true,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      home: HomePage(audioHandler: _audioHandler),
    );
  }
}
