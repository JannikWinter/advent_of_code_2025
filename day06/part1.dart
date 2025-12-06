import 'dart:io';

void main() {
  final File file = File("./day06/input");
  final List<List<String>> lines = file
      .readAsLinesSync()
      .map((line) => line.trim().split(RegExp(r"\s+")))
      .toList();
  final List<List<int>> valuesByRow = lines
      .sublist(0, lines.length - 1)
      .map((line) => line.map((str) => int.parse(str)).toList())
      .toList();
  final List<String> operationsByColumn = lines.last;

  final List<int> resultsByColumn = operationsByColumn
      .map((opStr) => opStr == "+" ? 0 : 1)
      .toList();

  for (final List<int> row in valuesByRow) {
    for (int i = 0; i < row.length; i++) {
      if (operationsByColumn[i] == "+") {
        resultsByColumn[i] += row[i];
      } else {
        resultsByColumn[i] *= row[i];
      }
    }
  }

  final int result = resultsByColumn.reduce(
    (value, element) => value + element,
  );

  print(result);
}
