import 'package:decoding_text_effect/decoding_text_effect.dart';
import 'package:flutter/widgets.dart';

class HeaderText extends StatefulWidget {
  const HeaderText({
    Key key,
  }) : super(key: key);

  @override
  _HeaderTextState createState() => _HeaderTextState();
}

class _HeaderTextState extends State<HeaderText> {
  String defaultText = '#cyber_vision ';
  String text;

  @override
  Widget build(BuildContext context) {
    return DecodingTextEffect(
      text ?? defaultText,
      decodeEffect: DecodeEffect.fromStart,
      textStyle: TextStyle(fontSize: 18),
      eachCount: 1,
      refreshDuration: Duration(milliseconds: 100),
      onFinished: () async {
        await Future.delayed(Duration(seconds: 10));
        setState(() {
          text = '#cYbe#_VI_io. ';
        });
        await Future.delayed(Duration(milliseconds: 1200));
        setState(() {
          text = defaultText;
        });
      },
    );
  }
}
