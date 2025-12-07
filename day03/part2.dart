import 'dart:io';

const int nDigits = 12;

void main() {
  final File file = File("./day03/input");
  final int result = solveDay3Part2(file);
  print(result);
}

int solveDay3Part2(File file) {
  final List<String> lines = file.readAsLinesSync();

  List<int> resultValues = [];
  for (final String bank in lines) {
    final List<int> currentBankJoltages = [
      for (int i = 0; i < bank.length; i++) int.parse(bank.substring(i, i + 1)),
    ];
    final List<int> resultDigits = [];
    int lastDigitIndex = -1;

    while (resultDigits.length < nDigits) {
      final (int largestDigit, int largestDigitIndex) = _getLargestJoltage(
        currentBankJoltages,
        start: lastDigitIndex + 1,
        end: bank.length - (nDigits - resultDigits.length) + 1,
      );
      resultDigits.add(largestDigit);
      lastDigitIndex = largestDigitIndex;
    }

    resultValues.add(int.parse(resultDigits.join()));
  }

  final int sum = resultValues.reduce((value, element) => value + element);

  return sum;
}

/// [start] inclusive, [end] exclusive
(int, int) _getLargestJoltage(List<int> joltages, {int? start, int? end}) {
  int largestJoltage = 0;
  int largestJoltageIndex = -1;

  for (int i = start ?? 0; i < (end ?? joltages.length); i++) {
    final int digit = joltages[i];
    if (digit > largestJoltage) {
      largestJoltage = digit;
      largestJoltageIndex = i;
    }
  }

  return (largestJoltage, largestJoltageIndex);
}
