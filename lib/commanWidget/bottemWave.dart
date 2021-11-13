import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class BottomWave extends StatelessWidget {
  const BottomWave({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      isLoop: false,
      config: CustomConfig(
        gradients: [
          [Color(0xFF3A2DB3), Color(0xFF3A2DB1)],
          [Color(0xFFEC72EE), Color(0xFFFF7D9C)],
          [Color(0xFFfc00ff), Color(0xFF00dbde)],
          [Color(0xFF396afc), Color(0xFF2948ff)]
        ],
        durations: [1, 2, 3, 4],
        heightPercentages: [0.05, 0.07, 0.10, 0.15],
        blur: MaskFilter.blur(BlurStyle.inner, 5),
        gradientBegin: Alignment.centerLeft,
        gradientEnd: Alignment.centerRight,
      ),
      waveAmplitude: 1.0,
      backgroundColor: null,
      size: Size(double.infinity, 50.0),
    );
  }
}