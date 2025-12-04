import 'dart:io';

void main() {
  final File file = File("./day02/input");
  final String line = file.readAsStringSync();
  final List<(int, int)> ranges = line.split(",").map((rangeStr) {
    final [start, end] = rangeStr.split("-");
    return (int.parse(start), int.parse(end));
  }).toList();

  final List<int> invalidValues = [];
  for ((int, int) range in ranges) {
    for (int i = range.$1; i <= range.$2; i++) {
      final String str = i.toString();
      final int centerIndex = str.length ~/ 2;
      final String half1 = str.substring(0, centerIndex);
      final String half2 = str.substring(centerIndex);

      if (half1 == half2) {
        invalidValues.add(i);
      }
    }
  }

  final int sum = invalidValues.reduce((e1, e2) => e1 + e2);

  print(sum);
}
