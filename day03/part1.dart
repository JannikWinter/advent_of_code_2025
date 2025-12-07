import 'dart:io';

typedef BankJoltage = ({int joltage, int firstIndex, int lastIndex});

void main() {
  final File file = File("./day03/input");
  final int result = solveDay3Part1(file);
  print(result);
}

int solveDay3Part1(File file) {
  final List<String> lines = file.readAsLinesSync();

  List<int> bankJoltageValues = [];
  for (final String bank in lines) {
    final List<BankJoltage> currentBankJoltages =
        {for (int i = 0; i < bank.length; i++) bank.substring(i, i + 1)}
            .map(
              (joltageStr) => (
                joltage: int.parse(joltageStr),
                firstIndex: bank.indexOf(joltageStr),
                lastIndex: bank.lastIndexOf(joltageStr),
              ),
            )
            .toList();
    currentBankJoltages.sort((e1, e2) => e2.joltage.compareTo(e1.joltage));

    outer:
    for (BankJoltage firstJoltage in currentBankJoltages) {
      for (BankJoltage secondJoltage in currentBankJoltages) {
        if (firstJoltage.firstIndex < secondJoltage.lastIndex) {
          bankJoltageValues.add(
            firstJoltage.joltage * 10 + secondJoltage.joltage,
          );
          break outer;
        }
      }
    }
  }

  final int sum = bankJoltageValues.reduce((value, element) => value + element);

  return sum;
}
