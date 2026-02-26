import 'package:flutter/material.dart';

class CalcButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isOperator;
  final bool isWide;

  const CalcButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isOperator = false,
    this.isWide = false,
  });

  @override
  State<CalcButton> createState() => _CalcButtonState();
}

class _CalcButtonState extends State<CalcButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme
        .of(context)
        .colorScheme;

    final baseBackground = widget.isOperator
        ? scheme.primary
        : scheme.surface;

    final baseForeground = widget.isOperator
        ? scheme.onPrimary
        : scheme.onSurface;

    final pressedBackground = baseBackground.withValues(alpha: 0.75);

    return AnimatedScale(
      scale: _isPressed ? 0.95 : 1.0,
      duration: const Duration(milliseconds: 100),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18.0),
          onTap: widget.onPressed,
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
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