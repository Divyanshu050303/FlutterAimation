import 'dart:math';

import 'package:flutter/material.dart';

class CustomPainterAndPolygon extends StatefulWidget {
  const CustomPainterAndPolygon({super.key});

  @override
  State<CustomPainterAndPolygon> createState() =>
      _CustomPainterAndPolygonState();
}

class Polygon extends CustomPainter {
  final int sides;

  Polygon({required this.sides});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;
    final path = Path();
    final center = Offset(size.width / 2, size.width / 2);
    final angle = (2 * pi) / sides;
    final angles = List.generate(sides, (index) => index * angle);
    final radius = size.width / 2;
    path.moveTo(center.dx + radius * cos(0), center.dy + radius * sin(0));
    for (final angle in angles) {
      path.lineTo(
          center.dx + radius * cos(angle), center.dy + radius * sin(angle));
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is Polygon && oldDelegate.sides != sides;
}

class _CustomPainterAndPolygonState extends State<CustomPainterAndPolygon>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<int> _sidesAnimation;
  late final AnimationController _radiusController;
  late final Animation<double> _radiusAnimation;
  late final AnimationController _rotationController;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _sidesAnimation = IntTween(begin: 3, end: 10).animate(_animationController);
    _radiusController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _radiusAnimation = Tween<double>(begin: 20.0, end: 400.0)
        .chain(CurveTween(curve: Curves.bounceInOut))
        .animate(_radiusController);
    _rotationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * pi,
    ).chain(CurveTween(curve: Curves.easeInOut)).animate(_rotationController);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _animationController.repeat(reverse: true);
    _radiusController.repeat(reverse: true);
    _rotationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _radiusController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge(
              [_animationController, _radiusController, _rotationController]),
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateX(_rotationAnimation.value)
                ..rotateY(_rotationAnimation.value)
                ..rotateZ(_rotationAnimation.value),
              child: CustomPaint(
                painter: Polygon(sides: _sidesAnimation.value),
                child: SizedBox(
                  width: _radiusAnimation.value,
                  height: _radiusAnimation.value,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
