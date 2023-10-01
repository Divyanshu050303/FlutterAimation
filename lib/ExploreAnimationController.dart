import 'package:flutter/material.dart';

class ExploreAnimationController extends StatefulWidget {
  const ExploreAnimationController({super.key});

  @override
  State<ExploreAnimationController> createState() =>
      _ExploreAnimationControllerState();
}

class _ExploreAnimationControllerState extends State<ExploreAnimationController>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotate;
  late Animation<AlignmentGeometry>_animation;
  late Animation<AlignmentGeometry>_animation2;
  final List<Alignment> alignmentList = [
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
  ];

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2800));
    _animation =
        Tween<AlignmentGeometry>(
            begin: Alignment.bottomLeft, end: Alignment.topRight).animate(
            CurvedAnimation(
                parent: _animationController, curve: Curves.easeInCubic));

    _rotate=Tween<double>(begin: 0, end: 2).animate(CurvedAnimation(parent: _animationController, curve:Curves.easeInCubic));
            _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 200,
      color: Colors.white,
      child: AlignTransition(
        alignment: _animation,
        child: RotationTransition(
          turns: _rotate,
          child:  Container(
            height: 50,
            width: 50,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }
}
