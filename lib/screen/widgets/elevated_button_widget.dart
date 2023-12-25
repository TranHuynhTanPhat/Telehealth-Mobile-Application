import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class ElevatedButtonWidget extends StatefulWidget {
  const ElevatedButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
  });
  final String text;
  final Function()? onPressed;
  final Color? color;

  @override
  State<ElevatedButtonWidget> createState() => _ElevatedButtonWidgetState();
}

class _ElevatedButtonWidgetState extends State<ElevatedButtonWidget> {
  Color color = primary;
  @override
  void initState() {
    if (widget.color != null) {
      color = widget.color!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(
              vertical: dimensHeight() * 2, horizontal: dimensWidth() * 2.5),
        ),
        backgroundColor: MaterialStatePropertyAll(color),
        foregroundColor: const MaterialStatePropertyAll(white),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered) ||
                states.contains(MaterialState.pressed)) {
              return white.withOpacity(.3); //<-- SEE HERE
            }
            return null; // Defer to the widget's default.
          },
        ),
      ),
      child: Text(
        widget.text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: white),
      ),
    );
  }
}
