import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dart:async';

class FlashLine extends StatefulWidget {
  const FlashLine({Key key}) : super(key: key);

  @override
  _FlashLineState createState() => _FlashLineState();
}

class _FlashLineState extends State<FlashLine> {
  Timer _timer;
  bool show = true;

  void startTimer() {
    _timer = Timer.periodic(
      Duration(milliseconds: 600),
      (Timer timer) => setState(
        () {
          show = !show;
        },
      ),
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 16,
        width: 4,
        color: show ? Theme.of(context).primaryColor : Colors.transparent);
  }
}
