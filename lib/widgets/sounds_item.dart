import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cyber_vision/widgets/polygon_draver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SoundsItem extends StatefulWidget {
  const SoundsItem({this.sound, this.player, this.needPlay = false, Key key})
      : super(key: key);

  final String sound;
  final AudioCache player;
  final bool needPlay;

  @override
  _SoundsItemState createState() => _SoundsItemState();
}

class _SoundsItemState extends State<SoundsItem>
    with SingleTickerProviderStateMixin {
  bool enable = true;

  AudioPlayer playerController;
  AnimationController _animation;
  CurvedAnimation _curvedAnimation;
  Animation<Color> _colorTweenAnimation;

  void playStop() async {
    if (enable) {
      if (playerController != null) {
        await playerController.stop();
      }
      final sound = await widget.player
          .loop('${widget.sound}.mp3', mode: PlayerMode.LOW_LATENCY);
      setState(() {
        playerController = sound;
        enable = false;
      });
      _animation.forward();
    } else {
      await playerController.stop();
      setState(() {
        enable = true;
      });
      _animation.reverse();
    }
  }

  @override
  void initState() {
    _animation = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _curvedAnimation =
        CurvedAnimation(curve: Curves.bounceOut, parent: _animation);

    if (widget.needPlay) {
      playStop();
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _colorTweenAnimation = ColorTween(
            begin: Colors.transparent, end: Theme.of(context).accentColor)
        .animate(_curvedAnimation);
    super.didChangeDependencies();
  }

  Future disposePlayer() async {
    if (playerController != null) {
      await playerController.stop();
      await playerController.dispose();
    }
  }

  @override
  void dispose() {
    disposePlayer();
    _animation.dispose();
    super.dispose();
  }

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
      child: AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget child) {
          return ClipPath(
            clipper: HexagonClipper(),
            child: ColorFiltered(
              colorFilter:
                  ColorFilter.mode(_colorTweenAnimation.value, BlendMode.hue),
              child: child,
            ),
          );
        },
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
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 12),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/bg/button_border.png'),
                      fit: BoxFit.contain)),
            ),
          ],
        ),
      ),
    );
  }
}

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return PolygonPathDrawer(
            size: Size(size.width, size.height),
            specs: PolygonPathSpecs(sides: 6, rotate: 0, borderRadiusAngle: 0))
        .draw();
  }

  @override
  bool shouldReclip(HexagonClipper oldClipper) => false;
}
