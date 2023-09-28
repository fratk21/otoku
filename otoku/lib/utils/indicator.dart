import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatefulWidget {
  @override
  _CustomProgressIndicatorState createState() =>
      _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..repeat(); // Animasyonu sürekli olarak tekrarlayın.
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RotationTransition(
            turns: _controller,
            child: Container(
              width: 100, // Resmin genişliğini ayarlayın
              height: 100, // Resmin yüksekliğini ayarlayın
              child: Image.asset('assets/image/anime.png'), // Dönen resim
            ),
          ),
          SizedBox(height: 20),
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText('Loading...'),
              TypewriterAnimatedText('Loading...'),
              TypewriterAnimatedText('Loading...'),
              TypewriterAnimatedText('Loading...'),
              TypewriterAnimatedText('Loading...'),
            ],
            isRepeatingAnimation: true,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
