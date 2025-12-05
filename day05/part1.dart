import 'dart:io';

void main() {
  File file = File("./day05/input");
  String input = file.readAsStringSync();

  final [freshIdRangesStr, availableIdsStr] = input.split("\n\n");

  final List<(int, int)> freshIdRanges = freshIdRangesStr.split("\n").map((
    rangeStr,
  ) {
    final [startStr, endStr] = rangeStr.split("-");
    return (int.parse(startStr), int.parse(endStr));
  }).toList();
  final List<int> availableIds = availableIdsStr
      .split("\n")
      .map((str) => int.parse(str))
      .toList();

  int result = 0;
  outer:
  for (final int id in availableIds) {
    for (final (int, int) range in freshIdRanges) {
      if (id >= range.$1 && id <= range.$2) {
        result++;
        continue outer;
      }
    }
  }

  print(result);
}
