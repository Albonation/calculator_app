//this is a custom button widget for the calculator app
//it handles both digit and operator buttons
//with different styling based on the type of button
//implements a not so secret fourth enhanced feature: a subtle press animation for better user feedback

import 'package:flutter/material.dart';

class CalcButton extends StatefulWidget {
  final String label; //text on the button
  final VoidCallback onPressed; //callback for when the button is pressed
  final bool isOperator; //if true, the button will have operator styling (different color)
  final bool isWide; //if true, the button will be wider (used for the '0' button)

  const CalcButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isOperator = false,
    this.isWide = false,
  });

  //creates a stateful widget to handle the pressed state for animation
  @override
  State<CalcButton> createState() => _CalcButtonState();
}

class _CalcButtonState extends State<CalcButton> {
  //track state of whether the button is currently pressed for animation purposes
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    //get the current theme's color scheme
    final scheme = Theme
        .of(context)
        .colorScheme;

    //determine base background colors based on whether the button is an operator or not
    final baseBackground = widget.isOperator
        ? scheme.primary
        : scheme.surface;

    //determine foreground color (text color) based on whether the button is an operator or not
    final baseForeground = widget.isOperator
        ? scheme.onPrimary
        : scheme.onSurface;

    //pressed state will have a slightly darker background for visual feedback
    final pressedBackground = baseBackground.withValues(alpha: 0.75);

    //use AnimatedScale for a subtle shrinking effect when pressed
    return AnimatedScale(
      scale: _isPressed ? 0.95 : 1.0,
      duration: const Duration(milliseconds: 100),
      //to create the ripple effect on tap
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18.0),
          onTap: widget.onPressed,
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          //to animate the background color and shadow when the button is pressed
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            height: 62,
            width: widget.isWide ? 140 : 62,
            decoration: BoxDecoration(
              color: _isPressed ? pressedBackground : baseBackground,
              borderRadius: BorderRadius.circular(18.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: _isPressed ? 6 : 14,
                  offset: _isPressed ? const Offset(0, 3) : const Offset(0, 6),
                  color: Colors.black.withValues(alpha: 0.12),
                ),
              ],
            ),
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: baseForeground,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}