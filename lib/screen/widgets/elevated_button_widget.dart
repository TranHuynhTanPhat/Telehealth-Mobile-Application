import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';



class ElevatedButtonWidget extends StatefulWidget {
  const ElevatedButtonWidget({
    super.key,
    required this.text, required this.onPressed,
  });
  final String text;
  final Function()? onPressed;

  @override
  State<ElevatedButtonWidget> createState() => _ElevatedButtonWidgetState();
}

class _ElevatedButtonWidgetState extends State<ElevatedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: dimensHeight() * 1, horizontal: dimensWidth()*2.5),
        ),
        backgroundColor: const MaterialStatePropertyAll(primary),
      ),
      child: Text(
        widget.text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: white),
      ),
    );
  }
}
