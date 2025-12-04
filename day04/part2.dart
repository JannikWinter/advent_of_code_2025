import 'dart:io';

import '../util.dart';

const List<(int, int)> neighborOffsets = [
  (-1, -1),
  (-1, 0),
  (-1, 1),
  (0, -1),
  (0, 1),
  (1, -1),
  (1, 0),
  (1, 1),
];

Iterable<(int, int)> getNeighborIndices(
  int x,
  int y,
  int width,
  int height,
) sync* {
  for (final (int xOffset, int yOffset) in neighborOffsets) {
    final int xResult = x + xOffset;
    final int yResult = y + yOffset;

    if (xResult < 0 || xResult >= width) continue;
    if (yResult < 0 || yResult >= height) continue;

    yield (xResult, yResult);
  }
}

void main() {
  final File file = File("./day04/input");
  final List<String> lines = file.readAsLinesSync();

  final List<List<int>> rows = lines
      .map((line) => line.chars.map((char) => char == "@" ? 1 : 0).toList())
      .toList();

  final int height = rows.length;
  final int width = rows[0].length;

  int removedRolls = 0;
  bool removedRollsInLastIteration;
  do {
    removedRollsInLastIteration = false;
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        if (rows[y][x] == 0) continue;

        int nNeighbors = getNeighborIndices(x, y, width, height)
            .map((index) => rows[index.$2][index.$1])
            .reduce((value, element) => value + element);

        if (nNeighbors < 4) {
          rows[y][x] = 0;
          removedRolls++;
          removedRollsInLastIteration = true;
        }
      }
    }
  } while (removedRollsInLastIteration);

  print(removedRolls);
}
