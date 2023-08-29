import 'package:flutter/material.dart';

class AnimationImplicit extends StatefulWidget {
  const AnimationImplicit({super.key});

  @override
  State<AnimationImplicit> createState() => _AnimationImplicitState();
}
const defaultWidth=100.0;
class _AnimationImplicitState extends State<AnimationImplicit> {
  var _isZoomedIn=false;
  var _buttonTitle='zoom In';
  var _width=defaultWidth;
  var _curve=Curves.bounceOut;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Implicit Animation")),
      ),
      body:   SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration:const   Duration(microseconds: 370),
                  curve: _curve,
                  width: _width,
                  height: 300,
                  child:Image.asset("assets/wallpaper.png") ,
                ),
              ],
            ),
            TextButton(
                onPressed: (){
                  setState(() {
                    _isZoomedIn=!_isZoomedIn;
                    _buttonTitle=_isZoomedIn?"Zoom Out" : "Zoom In";
                    _width=_isZoomedIn?MediaQuery.of(context).size.width:defaultWidth;
                    _curve=_isZoomedIn?Curves.bounceOut:Curves.bounceIn;
                  });
                },
                child: Text(_buttonTitle))
          ],
        ),
      ),
    );
  }
}
