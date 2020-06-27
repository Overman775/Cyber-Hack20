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
      if (playerController != null) {
        await playerController.stop();
      }
      final sound = await widget.player
          .loop('${widget.sound}.wav', mode: PlayerMode.LOW_LATENCY);
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

/*
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: enable
                    ? Theme.of(context).primaryColor.withOpacity(0.5)
                    : Theme.of(context).primaryColor.withOpacity(0),
                blurRadius: 20.0, // has the effect of softening the shadow
                spreadRadius: 1.0, // has the effect of extending the shadow
              )
            ],
          ),
          child: IconButton(
            icon: Text(
              '▶',
              style: TextStyle(
                  fontSize: 23,
                  color: enable
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColor.withOpacity(0.5)),
            ),
            onPressed: playStop,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(widget.sound)
      ],
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /* onTapDown: (_) {
        playStop(true);
      },
      onTapCancel: () {
        playStop(false);
      },
      onTapUp: (_) {
        playStop(false);
      },
      onDoubleTap: () {
        playStop(true);
      },*/
      onTap: playStop,
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.75,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/bg/bg_button.gif'),
                      fit: BoxFit.cover)),
            ),
          ),
          Center(
            child: Text(
              widget.sound,
              style:
                  TextStyle(color: Theme.of(context).accentColor, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
