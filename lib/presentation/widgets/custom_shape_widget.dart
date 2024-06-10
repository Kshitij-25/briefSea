import 'package:flutter/material.dart';

class CustomShapeWidget extends StatefulWidget {
  const CustomShapeWidget({super.key});

  @override
  _MyPainterState createState() => _MyPainterState();
}

class _MyPainterState extends State<CustomShapeWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: CustomPaint(
        size: Size(size.width, size.height),
        painter: Curved(),
      ),
    );
  }
}

class Curved extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    // Path rectPathThree = Path();
    Paint paint = Paint();
    paint.shader = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [.01, .25],
      colors: [Color(0xff1B0C6B), Color(0xff1B0C6B)],
    ).createShader(rect);

    var path = Path();

    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.07,
      size.width * 0.55,
      size.height * 0.07,
    );
    path.quadraticBezierTo(
      size.width * 0.2,
      size.height * 0.07,
      size.width * 0.1,
      size.height * 0.16,
    );
    path.quadraticBezierTo(
      size.width * 0.06,
      size.height * 0.2,
      size.width * 0,
      size.height * 0.2,
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

// FOR PAINTING THE CIRCLE
class CirclePainter extends CustomPainter {
  final double radius;
  CirclePainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var path = Path();
    path.addOval(Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius,
    ));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
