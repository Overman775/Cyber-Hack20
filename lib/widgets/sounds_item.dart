import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SoundsItem extends StatelessWidget {
  const SoundsItem({this.sound, key}) : super(key: key);

  final String sound;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.play_arrow,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {},
        ),
        Text(sound)
      ],
    );
  }
}
