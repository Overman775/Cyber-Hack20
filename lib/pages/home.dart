import 'package:cyber_hack20/widgets/sounds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/bg/1.gif'), fit: BoxFit.cover)),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    ' #cyber_drum_Pad »',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Expanded(child: Sounds()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
