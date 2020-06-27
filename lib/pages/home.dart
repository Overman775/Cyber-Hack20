import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
          color: Colors.black,
          panel: Column(
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Center(
                child: Text(
                  'Sounds',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bg/1.gif'), fit: BoxFit.cover)),
          )),
    );
  }
}
