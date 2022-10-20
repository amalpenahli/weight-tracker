

import 'package:flutter/material.dart';


enum ButtonState { init, loading, done }

class AnimationButton extends StatefulWidget {
  final  Function onTap;
  const AnimationButton( {super.key, required this.onTap});

  @override
  State<AnimationButton> createState() => _AnimationButtonState();
}

class _AnimationButtonState extends State<AnimationButton> {
  ButtonState state = ButtonState.init;
  bool isAnimating = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isStreched = isAnimating || state == ButtonState.init;
    final isDone = state == ButtonState.done;
    return 
       Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(32),
        child: AnimatedContainer(
          duration:const Duration(milliseconds: 300),
          curve: Curves.easeIn,
          width: state == ButtonState.init ? width : 70,
          onEnd: () => setState(() => isAnimating = !isAnimating),
          height: 70,
          child: isStreched ? buildButton() : buildSmallButton(isDone),
        ),
      );
    
  }

  Widget buildButton() => ElevatedButton(
    
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.lightBlueAccent,
            shape: const StadiumBorder(),
            side:const BorderSide(width: 2, color: Colors.lightBlueAccent)),
        child: const Text(
          'submit',
          style: TextStyle(
              fontSize: 24,
              color: Colors.indigo,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600),
        ),
        onPressed: () async {
          
          setState(() => state = ButtonState.loading);
          await Future.delayed(const Duration(seconds: 3));
          setState(() => state = ButtonState.done);
          await Future.delayed(const Duration(seconds: 3));
          setState(() => state = ButtonState.init);
        },
      );
}

Widget buildSmallButton(bool isDone) {
  final color = isDone ? Colors.green : Colors.lightBlueAccent;
  return Container(
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    child: Center(
      child: isDone
          ? const Icon(
              Icons.done,
              size: 52,
              color: Colors.white,
            )
          : const CircularProgressIndicator(color: Colors.white),
    ),
  );
}
