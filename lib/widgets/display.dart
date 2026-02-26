//this widget is responsible for displaying the current input and result of the calculator
//it adapts its styling based on the current theme and whether the displayed text is an error message or not

import 'package:flutter/material.dart';

class CalcDisplay extends StatelessWidget {
  final String text;//the text to display, which can be the current input or the result of a calculation
  final bool isError;//if true, the text is an error message and will be styled differently (red color)

  const CalcDisplay({
    super.key,
    required this.text,
    required this.isError,
  });

  @override
  Widget build(BuildContext context) {
    //get the current theme's color scheme
    final scheme = Theme
        .of(context)
        .colorScheme;
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;

    //background color is the surface color of the theme
    //text color is red if it's an error, otherwise use onSurface
    final backgroundColor = isDark
        ? scheme.surface.withValues(alpha: 0.95)
        : scheme.surface.withValues(alpha: 0.95);

    final displayTextColor = isError
        ? Colors.red
        : scheme.onSurface;

    //the display is a container with padding, rounded corners and a subtle shadow
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 10),
            color: Colors.black.withValues(alpha: 0.12),
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerRight,
          child: Text(
            text,
            maxLines: 1,
            style: TextStyle(
              fontSize: 46,
              fontWeight: FontWeight.w800,
              color: displayTextColor,
            ),
          ),
        ),
      ),
    );
  }
}