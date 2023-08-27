import 'package:flutter/material.dart';
import 'dart:math';

enum CircleSide { left, right }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockwise;
    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }
    path.arcToPoint(offset,
        radius: Radius.elliptical(size.width / 2, size.height / 2),
        clockwise: clockwise);
    path.close();
    return path;
  }
}

class ChainedAnimation extends StatefulWidget {
  const ChainedAnimation({super.key});

  @override
  State<ChainedAnimation> createState() => _ChainedAnimationState();
}

extension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide side;

  const HalfCircleClipper({required this.side});

  @override
  Path getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class _ChainedAnimationState extends State<ChainedAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: -(pi / 2))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
    _flipController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _flipAnimation = Tween<double>(begin: 0, end: pi)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
    _controller.addStatusListener((status) {
       if(status==AnimationStatus.completed){
         _flipAnimation=Tween<double>(begin: _flipAnimation.value,end: _flipAnimation.value+pi).animate(
           CurvedAnimation(
             parent: _flipController,
             curve: Curves.bounceOut
           )
         );
         _flipController..reset()..forward();
       }
    });
    _flipController.addStatusListener((status) {
      if(status==AnimationStatus.completed){
        _animation = Tween<double>(
            begin: _animation.value,
            end: _animation.value+ -(pi / 2))
            .animate(
            CurvedAnimation(
                parent: _controller,
                curve: Curves.bounceOut));
      }
      _controller..reset()..forward();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller
      ..reset()
      ..forward.delayed(const Duration(seconds: 1));
    return Scaffold(
      body: SafeArea(
          child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..rotateZ(_animation.value),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              AnimatedBuilder(animation: _flipController, builder: (context, child){
                return   Transform(
                  alignment: Alignment.centerRight,
                  transform: Matrix4.identity()..rotateY(_flipAnimation.value),
                  child: ClipPath(
                    clipper: const HalfCircleClipper(side: CircleSide.left),
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.red,
                    ),
                  ),
                );
              }),
               AnimatedBuilder(animation: _flipController, builder: (context, child){
                return Transform(
                  transform: Matrix4.identity()..rotateY(_flipAnimation.value),
                  alignment: Alignment.centerLeft,
                  child: ClipPath(
                     clipper: const HalfCircleClipper(side: CircleSide.right),
                     child: Container(
                       width: 100,
                       height: 100,
                       color: Colors.yellow,
                     ),
                   ),
                );
               })
              ],
            ),
          );
        },
      )),
    );
  }
}
