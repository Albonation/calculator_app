//this widget represents the calculator keypad,
//containing all the buttons for digits, operators, and actions
//it uses the CalcButton widget for each button and organizes them in rows.
//the callbacks for each button are passed from the parent widget to handle the logic of the calculator.

import 'package:flutter/material.dart';
import 'calc_button.dart';

class Keypad extends StatelessWidget {
  final VoidCallback onClear;//clear the current input
  final VoidCallback onAllClear;//clear all inputs and reset the calculator
  final void Function(String) onDigit;//handle digit input
  final void Function(String) onOperator;//handle operator input
  final VoidCallback onEquals;//handle the equals button to calculate the result
  final VoidCallback onDecimal;//handle the decimal point input

  const Keypad({
    super.key,
    required this.onClear,
    required this.onAllClear,
    required this.onDigit,
    required this.onOperator,
    required this.onEquals,
    required this.onDecimal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //first row with clear, all clear, divide and multiply
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CalcButton(label: 'C', onPressed: onClear, isOperator: true),
            CalcButton(label: 'AC', onPressed: onAllClear, isOperator: true),
            CalcButton(label: '÷', onPressed: () => onOperator('÷'), isOperator: true),
            CalcButton(label: '×', onPressed: () => onOperator('×'), isOperator: true),
          ],
        ),
        const SizedBox(height: 12),

        //next rows with digits and operators utilizing the helper method
        _row(['7', '8', '9', '-'], onDigit, onOperator),
        const SizedBox(height: 12),
        _row(['4', '5', '6', '+'], onDigit, onOperator),
        const SizedBox(height: 12),
        _row(['1', '2', '3', '='], onDigit, onOperator, equals: true, onEquals: onEquals),
        const SizedBox(height: 12),

        //last row with 0 (wide), decimal and backspace
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CalcButton(label: '0', onPressed: () => onDigit('0'), isWide: true),
            CalcButton(label: '.', onPressed: onDecimal),
            CalcButton(label: '\u232B', onPressed: () => onOperator('\u232B'), isOperator: true),
            //backspace symbol
          ],
        ),
      ],
    );
  }

  //helper to create rows of buttons
  Widget _row(
      List<String> labels,
      void Function(String) onDigit,
      void Function(String) onOperator, {
        bool equals = false,
        VoidCallback? onEquals,
      }) {
    //create a row of buttons based on the labels, checking if they are operators or equals
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: labels.map((label) {
        final isOperator = label == '+' || label == '-' || label == '×' || label == '÷';
        if (label == '=') {
          return CalcButton(
            label: '=',
            onPressed: onEquals ?? () {},
            isOperator: true,
          );
        }
        //if it's an operator, use the onOperator callback
        if (isOperator) {
          return CalcButton(
            label: label,
            onPressed: () => onOperator(label),
            isOperator: true,
          );
        }
        //if it's a digit, use the onDigit callback
        return CalcButton(
          label: label,
          onPressed: () => onDigit(label),
        );
      }).toList(),//convert the list of labels to a list of buttons
    );
  }
}// end of keypad widget