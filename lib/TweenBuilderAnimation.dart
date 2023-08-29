import 'package:flutter/material.dart';

class TweenBuilderAnimation extends StatefulWidget {
  const TweenBuilderAnimation({super.key});

  @override
  State<TweenBuilderAnimation> createState() => _TweenBuilderAnimationState();
}

class _TweenBuilderAnimationState extends State<TweenBuilderAnimation> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("TweenAnimationBuilder")),
      ),
      body: ClipPath(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),

      ),
    );
  }
}
