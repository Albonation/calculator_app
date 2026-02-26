class CalcLogic {
  static double add(double a, double b) => a + b;
  static double sub(double a, double b) => a - b;
  static double mul(double a, double b) => a * b;

  static double div(double a, double b) {
    if (b == 0) {
      throw const CalcException('Cannot divide by 0');
    }
    return a / b;
  }

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
    }
  }
}

class CalcException implements Exception {
  final String message;
  const CalcException(this.message);

  @override
  String toString() => message;
}