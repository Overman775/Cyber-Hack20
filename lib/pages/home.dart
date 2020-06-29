import 'package:cyber_vision/widgets/background.dart';
import 'package:cyber_vision/widgets/flash_line.dart';
import 'package:cyber_vision/widgets/header_text.dart';
import 'package:cyber_vision/widgets/sounds.dart';
import 'package:cyber_vision/widgets/top_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final soundsKey = GlobalKey<SoundsState>();
    final bgKey = GlobalKey<BackgroundState>();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Background(
              key: bgKey,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[HeaderText(), FlashLine()],
                ),
                const SizedBox(
                  height: 32,
                ),
                Expanded(
                    child: Sounds(
                  key: soundsKey,
                )),
              ],
            ),
            TopPanel(soundsKey: soundsKey, bgKey: bgKey),
          ],
        ),
      ),
    );
  }
}
