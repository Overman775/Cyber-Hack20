import 'package:audioplayers/audio_cache.dart';
import 'package:cyber_hack20/widgets/sounds_item.dart';
import 'package:flutter/widgets.dart';

class Sounds extends StatelessWidget {
  Sounds({Key key}) : super(key: key);

  final List<String> sounds = [
    'tron',
    'theme',
    'vocal',
    'talkbox',
    'loop',
    'lead',
    'guitar',
    'chords',
    'bass',
  ];

  final AudioCache player = AudioCache(prefix: 'sounds/');

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceAround,
      runSpacing: 16,
      spacing: 16,
      children: sounds
          .map((item) => SoundsItem(
                sound: item,
                player: player,
              ))
          .toList(),
    );
  }
}
