import 'package:flutter/material.dart';
import 'dart:math' as math;



class TweenBuilderAnimation extends StatefulWidget {
  const TweenBuilderAnimation({super.key});

  @override
  State<TweenBuilderAnimation> createState() => _TweenBuilderAnimationState();
}
class CircleClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    
  var path=Path();
  final rect=Rect.fromCircle(center: Offset(size.width/2, size.height/2), radius: size.width/2);
  path.addOval(rect);
  return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) =>false;

}
Color getRandomColor() => Color(
    0xFF000000 + math.Random().nextInt(0x00FFFFFF)
);
class _TweenBuilderAnimationState extends State<TweenBuilderAnimation> {
  var _color=getRandomColor();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("TweenAnimationBuilder")),
      ),
      body: Center(
        child: ClipPath(
          clipper: CircleClipper(),
          child:TweenAnimationBuilder(
            tween: ColorTween(
              begin: getRandomColor(),
              end: _color
            ),
            onEnd: (){
              setState(() {
                _color=getRandomColor();
              });
            },
            duration: Duration(seconds: 1),
              child:Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                color: Colors.red,
              ),
            builder: (context, Color? color,child){
              return ColorFiltered(
                  colorFilter: ColorFilter.mode(color!,BlendMode.srcATop),
                  child: child!) ;
            },
          ),



        ),
      ),
    );
  }
}
