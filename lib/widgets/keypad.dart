import 'package:flutter/material.dart';
import 'calc_button.dart';

class Keypad extends StatelessWidget {
  final VoidCallback onClear;
  final VoidCallback onAllClear;
  final void Function(String) onDigit;
  final void Function(String) onOperator;
  final VoidCallback onEquals;
  final VoidCallback onDecimal;

  const Keypad({
    super.key,
    required this.onClear,
    required this.onAllClear,
    required this.onDigit,
    required this.onOperator,
    required this.onEquals,
    required this.onDecimal,
  });
}