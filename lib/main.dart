import 'package:flutter/material.dart';

import 'mapgencanvas.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(D6MapGen());
}

class D6MapGen extends StatefulWidget {
  @override
  D6MapGenState createState() => D6MapGenState();
}

class D6MapGenState extends State<D6MapGen> {
  double perlinTemperature = 0.4;
  double perlinFrequency = 0.034;
  double perlinSeed = 129837;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      home: Scaffold(
        // Outer white container with padding

        body: Column(
          children: [
            SizedBox(
              height: 29,
            ),
            Row(
              children: [
                Text("perlinSeed"),
                Expanded(
                    child: Slider(
                  value: perlinSeed,
                  min: 0,
                  max: 200000,
                  divisions: 200000,
                  label: perlinSeed.toString(),
                  onChanged: (double value) {
                    setState(() {
                      perlinSeed = value;
                    });
                  },
                )),
              ],
            ),
            Row(
              children: [
                Text("perlinTemperature"),
                Expanded(
                    child: Slider(
                  value: perlinTemperature,
                  min: 0,
                  max: 1,
                  divisions: 200,
                  label: perlinTemperature.toString(),
                  onChanged: (double value) {
                    setState(() {
                      perlinTemperature = value;
                    });
                  },
                )),
              ],
            ),
            Row(
              children: [
                Text("perlinFrequency"),
                Expanded(
                  child: Slider(
                    value: perlinFrequency,
                    min: 0,
                    max: 1,
                    divisions: 200,
                    label: perlinFrequency.toString(),
                    onChanged: (double value) {
                      setState(() {
                        perlinFrequency = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  color: Colors.white,
                  // Inner yellow container
                  child: LayoutBuilder(
                    builder: (_, constraints) => Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        color: Colors.white,
                        child: CustomPaint(
                            painter: MapDrawer(perlinTemperature,
                                perlinFrequency, perlinSeed))),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
