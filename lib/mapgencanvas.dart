import 'package:fast_noise/fast_noise.dart';
import 'package:flutter/material.dart';

Map<int, Paint> a = {
  0: Paint()..color = Color.fromRGBO(75, 184, 232, 1), // Sea
  1: Paint()..color = Color.fromRGBO(186, 142, 84, 1), // Sand
  2: Paint()..color = Color.fromRGBO(136, 226, 89, 1), // Grass
  3: Paint()..color = Color.fromRGBO(83, 142, 45, 1), // Forest
  4: Paint()..color = Color.fromRGBO(43, 81, 20, 1), // Dense Forest
  5: Paint()..color = Color.fromRGBO(127, 65, 34, 1), // Mountain
};

class MapDrawer extends CustomPainter {
  double perlinTemperature;
  double perlinFrequency;
  double perlinSeed;
  List<int> resolution = [60, 60];
  List<List<double>> noiseData = [[]];
  MapDrawer(this.perlinTemperature, this.perlinFrequency, this.perlinSeed) {
    noiseData = noise2(resolution[0], resolution[1],
        seed: perlinSeed.toInt(),
        noiseType: NoiseType.PerlinFractal,
        frequency: this.perlinFrequency);
  }

  @override
  void paint(Canvas canvas, Size size) {
    List<int> squareSize = [
      size.width ~/ resolution[0],
      size.height ~/ resolution[1]
    ];

    noiseData.asMap().forEach((row, rowData) {
      rowData.asMap().forEach((column, value) {
        var v = ((value + this.perlinTemperature) * 256).clamp(0, 255) ~/ 51;

        var left = row.toDouble() * squareSize[0];
        var right = left + squareSize[0] + 1;

        var top = (column.toDouble() * squareSize[1]);
        var bottom = top + squareSize[1] + 1;

        canvas.drawRect(Rect.fromLTRB(left, top, right, bottom), a[v]!);
      });
    });
  }

  @override
  bool shouldRepaint(MapDrawer oldDelegate) => false;
}
