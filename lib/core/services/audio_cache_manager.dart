import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class AudioCacheManager {
  final AudioPlayer _player = AudioPlayer();

  Future<void> play(String url, {String? filename}) async {
    final dir = await getApplicationDocumentsDirectory();

    final name = filename ?? url.split('/').last;
    final file = File('${dir.path}/$name');

    if (!await file.exists()) {
      final bytes = await http.readBytes(Uri.parse(url));
      await file.writeAsBytes(bytes);
    }

    await _player.play(DeviceFileSource(file.path));
  }

  Future<void> pause() async => await _player.pause();

  Future<void> stop() async => await _player.stop();

  Future<void> resume() async => await _player.resume();

  Future<void> dispose() async => await _player.dispose();
}
