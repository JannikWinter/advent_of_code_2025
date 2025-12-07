import 'dart:io';

import '../util.dart';

void main() {
  final File file = File("./day07/input");
  final List<String> lines = file.readAsLinesSync();

  final List<Set<int>> splitterIndicesByRow = lines
      .skip(1)
      .map(
        (line) => line.chars.indexed
            .where((indexedChar) => indexedChar.$2 == "^")
            .map((indexedChar) => indexedChar.$1)
            .toSet(),
      )
      .toList();

  Map<int, int> activeBeamCountsByIndex = {
    for (int i = 0; i < lines[0].length; i++) i: 0,
    lines.first.indexOf("S"): 1,
  };

  for (final Set<int> currentRowSplitterIndices in splitterIndicesByRow) {
    final Map<int, int> previousBeamCounts = Map.from(activeBeamCountsByIndex);
    final Map<int, int> nextBeamCounts = {};
    for (final int beamIndex in previousBeamCounts.keys) {
      if (currentRowSplitterIndices.contains(beamIndex)) {
        nextBeamCounts[beamIndex] = 0;
      }
    }
  }

  final int nTimelines = activeBeamCountsByIndex.length;
  print(nTimelines);
}
