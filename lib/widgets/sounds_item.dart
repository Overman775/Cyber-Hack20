import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SoundsItem extends StatefulWidget {
  const SoundsItem({this.sound, this.player, key}) : super(key: key);

  final String sound;
  final AudioCache player;

  @override
  _SoundsItemState createState() => _SoundsItemState();
}

class _SoundsItemState extends State<SoundsItem> {
  bool enable = true;

  AudioPlayer playerController;

  void playStop() async {
    if (enable) {
      final sound = await widget.player.loop('${widget.sound}.wav');
      setState(() {
        playerController = sound;
        enable = false;
      });
    } else {
      await playerController.stop();
      setState(() {
        enable = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.play_arrow,
            color: enable
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor.withOpacity(0.5),
          ),
          onPressed: playStop,
        ),
        Text(widget.sound)
      ],
    );
  }
}
