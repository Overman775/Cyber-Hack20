import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:cyber_vision/widgets/sounds_item.dart';
import 'package:flutter/widgets.dart';

class Sounds extends StatefulWidget {
  Sounds({Key key}) : super(key: key);

  @override
  SoundsState createState() => SoundsState();
}

class SoundsState extends State<Sounds> with SingleTickerProviderStateMixin {
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

  final List<String> soundsNeedPlay = [
    'chill',
    'solo',
  ];

  List<String> get files => sounds.map((sound) => sound + '.mp3').toList();
  final AudioCache player = AudioCache(prefix: 'sounds/');

  AnimationController _animation;

  @override
  void initState() {
    _animation = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _generateanimationMap();
    super.initState();
  }

  void hideShowPanel() async {
    if (_animation.value > 0) {
      await _animation.reverse();
    } else {
      await _animation.forward();
    }
  }

  final Map<String, CurvedAnimation> _animationMap = {};

  void _generateanimationMap() {
    sounds.forEach((sound) {
      _animationMap[sound] = lineDelayedAnimation(sound);
    });
  }

  CurvedAnimation lineDelayedAnimation(String item) {
    final delay = 1 / sounds.length;
    final index = sounds.indexOf(item);
    if (index < 6) {
      return CurvedAnimation(
          parent: _animation,
          curve: Interval(index * delay, (index + 1) * delay,
              curve: Curves.easeInOut));
    } else {
      final revesIndex = (index - 11) * -1;
      return CurvedAnimation(
          parent: _animation,
          curve: Interval(revesIndex * delay, (revesIndex + 1) * delay,
              curve: Curves.easeInOut));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<File>>(
        future: player.loadAll(files),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            return SizedBox.shrink();
          }
          _animation.forward();
          return Container(
            child: GridView.count(
              crossAxisCount: 6,
              childAspectRatio: 1.0,
              padding: const EdgeInsets.all(16.0),
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              physics: const NeverScrollableScrollPhysics(),
              children: sounds
                  .map((item) => AnimatedBuilder(
                        animation: _animation,
                        builder: (BuildContext context, Widget child) {
                          return Transform.scale(
                            scale: Tween(begin: 0.0, end: 1.0)
                                .evaluate(_animationMap[item]),
                            child: child,
                          );
                        },
                        child: SoundsItem(
                          sound: item,
                          player: player,
                          needPlay: soundsNeedPlay.contains(item),
                        ),
                      ))
                  .toList(),
            ),
          );
        });
  }
}
