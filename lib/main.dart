import 'package:chart_components/helper/path_drawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            height: 300,
            width: 300,
            child: CustomPaint(
              painter: MyPainter(),
            ),
          ),
        ),
      ),
    );
  }
}


class MyPainter extends CustomPainter {
  const MyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.addDashLine(toX: size.width, toY: size.height);
    canvas.drawPath(path, Paint()..strokeWidth = 1..color=Colors.black..style=PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
  
}