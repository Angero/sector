import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slider Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _value = 0.0; // Initial value of the slider

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slider Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleWidget(value: _value), // Pass the value to the CircleWidget
            SizedBox(height: 20),
            Slider(
              value: _value,
              onChanged: (newValue) {
                setState(() {
                  _value = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CircleWidget extends StatelessWidget {
  final double value; // The value of the slider (between 0 and 1)

  const CircleWidget({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CirclePainter(value),
      size: Size(200, 200),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final double value;

  _CirclePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final tealColor = Colors.teal;
    final redColor = Colors.red;

    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);

    final circlePaint = Paint()..color = tealColor;
    canvas.drawCircle(center, radius, circlePaint);

    final sectorPaint = Paint()
      ..color = redColor
      ..style = PaintingStyle.fill;
    final startAngle = -math.pi / 2;
    final sweepAngle = math.pi * 2 * value; // Calculate the sweep angle based on the slider value
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        sweepAngle, true, sectorPaint);
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) => false;
}
