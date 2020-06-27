import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:cyber_hack20/widgets/sounds_item.dart';
import 'package:flutter/widgets.dart';

class Sounds extends StatelessWidget {
  Sounds({Key key}) : super(key: key);

  final List<String> sounds = [
    'theme',
    'chords',
    'bass',
    'oxygen',
    'loop1',
    'loop2',
    'sleep',
    'chill',
    'solo',
    'happy',
    'angry',
    'slow',
  ];

  List<String> get files => sounds.map((sound) => sound + '.wav').toList();

  final AudioCache player = AudioCache(prefix: 'sounds/');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<File>>(
        future: player.loadAll(files),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            return SizedBox.shrink();
          }
          return Container(
            child: GridView.count(
              crossAxisCount: 6,
              childAspectRatio: 1.0,
              padding: const EdgeInsets.all(16.0),
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              physics: const NeverScrollableScrollPhysics(),
              children: sounds
                  .map((item) => SoundsItem(
                        sound: item,
                        player: player,
                      ))
                  .toList(),
            ),
          );
        });
  }
}
