//main screen of the calculator app, handles state management and user interactions
//includes error handling for invalid inputs and operations

import 'package:flutter/material.dart';
import '../utils/calc_logic.dart';
import '../widgets/display.dart';
import '../widgets/keypad.dart';

//stateful widget to manage the calculator's state
class CalcMainScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const CalcMainScreen({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<CalcMainScreen> createState() => _CalcMainScreenState();
}

class _CalcMainScreenState extends State<CalcMainScreen> {
  String _display = '0';
  bool _isError = false;//error handling feature

  double? _operand1;//stores the first operand for calculations, null if not set
  String? _operator;//stores the current operator, null if not set
  bool _shouldResetEntry = false; //when true, next digit starts fresh


  //sets the display to an error message and resets state variables
  void _setError(String msg) {
    setState(() {
      _display = msg;
      _isError = true;
      _operand1 = null;
      _operator = null;
      _shouldResetEntry = true;
    });
  }

  //clear the current entry without affecting the stored operand and operator
  //used for the "C" button enhanced feature
  void _clearEntry() {
    setState(() {
      _display = '0';
      _isError = false;
      _shouldResetEntry = false;
    });
  }

  //reset everything to the initial state
  //used for the "AC" button enhanced feature
  void _allClear() {
    setState(() {
      _display = '0';
      _isError = false;
      _operand1 = null;
      _operator = null;
      _shouldResetEntry = false;
    });
  }

  //handles digit input
  void _appendDigit(String digit) {
    setState(() {
      if (_isError) {
        _display = '0';
        _isError = false;
      }

      if (_shouldResetEntry) {
        _display = '0';
        _shouldResetEntry = false;
      }

      if (_display == '0') {
        _display = digit;
      } else {
        _display += digit;
      }
    });
  }

  //handles decimal point input
  //ensures only one decimal point is added and resets entry if needed
  void _appendDecimal() {
    setState(() {
      if (_isError) {
        _display = '0';
        _isError = false;
      }
      if (_shouldResetEntry) {
        _display = '0';
        _shouldResetEntry = false;
      }
      if (!_display.contains('.')) {
        _display += '.';
      }
    });
  }

  //try to parse the current display as a double, returns null if it fails
  //uses built-in double parsing which handles various edge cases and formats
  double? _tryParseDisplay() {
    final theDouble = double.tryParse(_display);
    return theDouble;
  }

  //handles operator button presses
  //sets the current operator and prepares for the next operand
  void _setOperator(String op) {
    if (op == '\u232B') {
      _backspace();
      return;
    }

    final current = _tryParseDisplay();
    if (current == null) {
      _setError('Error');
      return;
    }

    setState(() {
      _isError = false;

      //if we already have operand1 and operator and user changes operator,
      //just update operator without changing operand1
      _operand1 ??= current;
      _operator = op;
      _shouldResetEntry = true;
    });
  }

  //backspace functionality, allows users to correct their input without clearing everything
  //button uses the Unicode backspace symbol \u232B
  void _backspace() {
    setState(() {
      if (_isError || _shouldResetEntry) return;

      if (_display.length <= 1) {
        _display = '0';
      } else {
        _display = _display.substring(0, _display.length - 1);
        if (_display == '-' || _display.isEmpty) _display = '0';
      }
    });
  }

  //handles the "=" button press, performs the calculation and updates the display
  void _equals() {
    if (_operator == null || _operand1 == null) {
      //error handling feature where users press "=" without complete input
      _setError('Incomplete input');
      return;
    }

    final operand2 = _tryParseDisplay();
    if (operand2 == null) {
      _setError('Not a number');
      return;
    }

    //ties together the calculation logic with the UI
    //includes error handling for any exceptions thrown during calculation
    //displays user-friendly messages instead of crashing the app
    try {
      final result = CalcLogic.apply(_operand1!, operand2, _operator!);

      setState(() {
        _display = _formatResult(result);
        _isError = false;

        _operand1 = null;
        _operator = null;
        _shouldResetEntry = true;
      });
    } on CalcException catch (error) {
      _setError(error.message);
    } catch (_) {//catch any other unexpected errors to prevent crashes and show a generic error message
      _setError('Undefined Error');
    }
  }

  //formats the result to remove unnecessary trailing zeros and decimal points
  String _formatResult(double value) {
    final theString = value.toStringAsFixed(10);
    final trimmedString = theString.replaceFirst(RegExp(r'\.?0+$'), '');
    return trimmedString.isEmpty ? '0' : trimmedString;
  }


  //build method constructs the UI of the calculator
  @override
  Widget build(BuildContext context) {
    //accessing theme data to style the UI
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          //using built-in icons for light and dark mode to provide visual feedback on the current theme
          IconButton(
            tooltip: 'Toggle Theme',
            onPressed: widget.onToggleTheme,
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 26,
                    offset: const Offset(0, 18),
                    color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CalcDisplay(text: _display, isError: _isError),
                  const SizedBox(height: 18),
                  //passing the necessary callbacks to the Keypad widget to handle user interactions
                  Keypad(
                    onClear: _clearEntry,
                    onAllClear: _allClear,
                    onDigit: _appendDigit,
                    onOperator: _setOperator,
                    onDecimal: _appendDecimal,
                    onEquals: _equals,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}