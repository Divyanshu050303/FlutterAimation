import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedBuilder_and_Transform extends StatefulWidget {
  const AnimatedBuilder_and_Transform({super.key});

  @override
  State<AnimatedBuilder_and_Transform> createState() =>
      _AnimatedBuilder_and_TransformState();
}

class _AnimatedBuilder_and_TransformState
    extends State<AnimatedBuilder_and_Transform>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 100)
    );
    _animation=Tween<double>(begin: 0.0, end: 2*pi).animate(_controller);
    _controller.repeat();
  }
@override
  void dispose() {
   _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Padding(
            padding: const EdgeInsets.only(top: 48.0, left: 45 ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateX(_animation.value),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration:   BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10)
                        ),

                      ),
                    ),
                    const SizedBox(width: 40,),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(_animation.value),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration:   BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10)
                        ),

                      ),
                    ),
                  ],
                ),Row(
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateZ(_animation.value),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration:   BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10)
                        ),

                      ),
                    ),
                    const SizedBox(width: 40,),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateZ(_animation.value),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration:   BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10)
                        ),

                      ),
                    ),
                  ],
                ),Row(
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateX(_animation.value),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration:   BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10)
                        ),

                      ),
                    ),
                    const SizedBox(width: 40,),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(_animation.value),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration:   BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10)
                        ),

                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
