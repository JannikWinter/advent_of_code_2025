import 'dart:io';

void main() {
  final File file = File("./day02/input");
  final int result = solveDay2Part2(file);
  print(result);
}

int solveDay2Part2(File file) {
  final String line = file.readAsStringSync();
  final List<(int, int)> ranges = line.split(",").map((rangeStr) {
    final [start, end] = rangeStr.split("-");
    return (int.parse(start), int.parse(end));
  }).toList();

  final Set<int> invalidValues = {};
  for ((int, int) range in ranges) {
    for (int value = range.$1; value <= range.$2; value++) {
      final String str = value.toString();
      for (int subStrLen = 1; subStrLen <= str.length ~/ 2; subStrLen++) {
        if (str.length % subStrLen != 0) continue;

        final List<String> substrings = RegExp(
          "\\d{$subStrLen}",
        ).allMatches(str).map((match) => match.group(0)!).toList();

        if (substrings.every((substring) => substring == substrings[0])) {
          invalidValues.add(value);
        }
      }
    }
  }

  final int sum = invalidValues.reduce((e1, e2) => e1 + e2);

  return sum;
}
