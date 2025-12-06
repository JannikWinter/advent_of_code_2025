import 'dart:io';

import '../util.dart';

void main() {
  final File file = File("./day06/input");
  final List<List<String>> charactersByRow = file
      .readAsLinesSync()
      .map((line) => line.chars.toList())
      .toList();

  final int nRows = charactersByRow.length;
  final int nColumns = charactersByRow[0].length;

  int result = 0;

  String currentOperator = "";
  final List<int> currentBlockNumbers = [];
  for (int x = 0; x < nColumns; x++) {
    final String opChar = charactersByRow.last[x];
    if (opChar != " ") {
      currentOperator = opChar;
    }

    final List<String> digits = [];
    for (int y = 0; y < nRows - 1; y++) {
      final String digit = charactersByRow[y][x];
      digits.add(digit);
    }

    final String currentNumberStr = digits.join().trim();
    if (currentNumberStr.isNotEmpty) {
      final int currentNumber = int.parse(currentNumberStr);
      currentBlockNumbers.add(currentNumber);
    } else {
      final int currentBlockResult;
      switch (currentOperator) {
        case "+":
          currentBlockResult = currentBlockNumbers.reduce(
            (value, element) => value + element,
          );
        case "*":
          currentBlockResult = currentBlockNumbers.reduce(
            (value, element) => value * element,
          );
        default:
          throw Error();
      }
      result += currentBlockResult;

      currentOperator = "";
      currentBlockNumbers.clear();
    }
  }

  print(result);
}
