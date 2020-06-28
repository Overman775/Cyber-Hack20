import 'package:cyber_hack20/widgets/background.dart';
import 'package:cyber_hack20/widgets/sounds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TopPanel extends StatefulWidget {
  const TopPanel({this.soundsKey, this.bgKey, Key key}) : super(key: key);

  final GlobalKey<SoundsState> soundsKey;
  final GlobalKey<BackgroundState> bgKey;

  @override
  _TopPanelState createState() => _TopPanelState();
}

class _TopPanelState extends State<TopPanel> {
  bool hided = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      right: 16,
      child: Row(
        children: <Widget>[
          TopPaneltem(
            text: 'Change\nBG',
            onPress: widget.bgKey.currentState.changeBg,
          ),
          SizedBox(
            width: 16,
          ),
          TopPaneltem(
            text: hided ? 'Show\npanel' : 'Hide\npanel',
            onPress: () async {
              await widget.soundsKey.currentState.hideShowPanel();
              setState(() {
                hided = !hided;
              });
            },
          ),
        ],
      ),
    );
  }
}

class TopPaneltem extends StatelessWidget {
  const TopPaneltem({
    this.text,
    this.onPress,
    Key key,
  }) : super(key: key);

  final VoidCallback onPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg/bg_button.gif'),
                fit: BoxFit.cover)),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).accentColor, fontSize: 12),
        ),
      ),
    );
  }
}
