import 'dart:math';

import 'package:fast_noise/fast_noise.dart';
import 'package:flutter/material.dart';

Map<int, Color> a = {
  0: Color.fromRGBO(75, 184, 232, 1), // Sea
  1: Color.fromRGBO(186, 142, 84, 1), // Sand
  2: Color.fromRGBO(136, 226, 89, 1), // Grass
  3: Color.fromRGBO(83, 142, 45, 1), // Forest
  4: Color.fromRGBO(43, 81, 20, 1), // Dense Forest
  5: Color.fromRGBO(127, 65, 34, 1), // Mountain
};

class FaceOutlinePainter extends CustomPainter {
  double perlinTemperature;
  double perlinFrequency;
  double perlinSeed;
  FaceOutlinePainter(
      this.perlinTemperature, this.perlinFrequency, this.perlinSeed);

  @override
  void paint(Canvas canvas, Size size) {
    var myNoise = noise2(50, 50,
        seed: perlinSeed.toInt(),
        noiseType: NoiseType.PerlinFractal,
        frequency: this.perlinFrequency);

    myNoise.asMap().forEach((row, rowData) {
      rowData.asMap().forEach((column, value) {
        var p = Paint();
        var v = ((value + this.perlinTemperature) * 256).clamp(0, 255) ~/ 52;

        p.color = a[v]!;

        var sqs = 8;
        var left = row.toDouble() * sqs;
        var right = left + sqs + 1;

        var top = (column.toDouble() * sqs);
        var bottom = top + sqs + 1;

        canvas.drawRect(Rect.fromLTRB(left, top, right, bottom), p);
      });
    });
  }

  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) => false;
}
