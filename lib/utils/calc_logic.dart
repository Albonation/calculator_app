//this class contains the logic for performing calculations in the calculator app
//it defines basic operations and a method to apply an operator to two operands
//it also includes error handling for division by zero and unknown operators

class CalcLogic {
  //define basic operations
  static double add(double a, double b) => a + b;
  static double sub(double a, double b) => a - b;
  static double mul(double a, double b) => a * b;

  //handle division and check for division by zero
  static double div(double a, double b) {
    if (b == 0) {
      throw const CalcException('Cannot divide by 0');
      //detect division by zero and throw a custom exception with a user-friendly message
    }
    return a / b;
  }

  //apply the operator to the operands and return the result
  static double apply(double a, double b, String op) {
    switch (op) {
      case '+':
        return add(a, b);
      case '-':
        return sub(a, b);
      case '×':
        return mul(a, b);
      case '÷':
        return div(a, b);
      default:
        throw const CalcException('Unknown operator');
        //error handling for unknown operators
        //should never happen with the current UI but a good default case for robustness
    }
  }
}

//custom exception for calculator errors
//part of the error handling feature to provide user-friendly error messages
class CalcException implements Exception {
  final String message;
  const CalcException(this.message);

  @override
  String toString() => message;
}