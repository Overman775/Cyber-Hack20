import 'package:flutter/widgets.dart';

class Background extends StatefulWidget {
  const Background({
    Key key,
  }) : super(key: key);

  @override
  BackgroundState createState() => BackgroundState();
}

class BackgroundState extends State<Background> {
  int currentBg = 0;
  final List<String> bg = ['1.gif', '2.gif'];

  String get currentBgLink => bg[currentBg];

  void changeBg() {
    var bgNext = currentBg + 1;
    if (bgNext > bg.length - 1) {
      bgNext = 0;
    }
    setState(() {
      currentBg = bgNext;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.fastOutSlowIn,
        switchOutCurve: Curves.easeOutExpo,
        reverseDuration: Duration(seconds: 1),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return BgTransistion(child: child, animation: animation);
        },
        child: Container(
          key: ValueKey<String>(currentBgLink),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg/$currentBgLink'),
                  fit: BoxFit.cover)),
        ));
  }
}

class BgTransistion extends AnimatedWidget {
  const BgTransistion({
    Key key,
    @required Animation<double> animation,
    this.child,
  })  : assert(animation != null),
        super(key: key, listenable: animation);

  Animation<double> get animation => listenable as Animation<double>;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: DrawClip(animation.value), child: child);
  }
}

class DrawClip extends CustomClipper<Path> {
  DrawClip(this.value);

  final double value;

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width * value, size.height);
    path.lineTo(size.width * value, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
