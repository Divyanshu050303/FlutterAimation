import 'dart:math';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'package:flutter/material.dart';

class animation3D extends StatefulWidget {
  const animation3D({super.key});

  @override
  State<animation3D> createState() => _animation3DState();
}

class _animation3DState extends State<animation3D> with TickerProviderStateMixin {
  late AnimationController _Xcontroller;
  late AnimationController _Ycontroller;
  late AnimationController _Zcontroller;
  late Tween<double> _animation;
  @override
  void initState() {
    super.initState();
    _Xcontroller=AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _Ycontroller=AnimationController(vsync: this, duration: const Duration(seconds: 30));
    _Zcontroller=AnimationController(vsync: this, duration: const Duration(seconds: 40));
    _animation=Tween<double>(
      begin: 0,
      end: pi*2
    ) ;
  }
@override
  void dispose() {
    _Xcontroller.dispose();
    _Ycontroller.dispose();
    _Zcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _Xcontroller..reset()..repeat();
    _Ycontroller..reset()..repeat();
    _Zcontroller..reset()..repeat();
    return   Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100,width: double.infinity,),
            AnimatedBuilder(
              animation: Listenable.merge([
                _Xcontroller,
                _Ycontroller,
                _Zcontroller
              ]),
              builder: (context, child){
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateX(_animation.evaluate(_Xcontroller))
                    ..rotateY(_animation.evaluate(_Ycontroller))
                    ..rotateZ(_animation.evaluate(_Zcontroller)),
                  child: Stack(
                    children: [
                      // front
                      Container(
                        color: Colors.green,
                        width: 100,
                        height: 100,
                      ),
                      // back
                      Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()..translate(Vector3(0,0,-100)),
                        child: Container(
                          color: Colors.red,
                          width: 100,
                          height: 100,
                        ),
                      ),
                      // left
                      Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()..rotateY(pi/2),
                        child: Container(
                          color: Colors.black,
                          width: 100,
                          height: 100,
                        ),
                      ),Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()..rotateY(-pi/2),
                        child: Container(
                          color: Colors.blue,
                          width: 100,
                          height: 100,
                        ),
                      ),Transform(
                        alignment: Alignment.topCenter,
                        transform: Matrix4.identity()..rotateX(-pi/2),
                        child: Container(
                          color: Colors.yellow,
                          width: 100,
                          height: 100,
                        ),
                      ),Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()..rotateX(pi/2),
                        child: Container(
                          color: Colors.pink,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ],
                  ),
                );
              },

            )
          ],
        ),
      ),
    );
  }
}
