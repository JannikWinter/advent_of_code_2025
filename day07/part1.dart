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

  final Set<int> currentBeamIndices = {lines.first.indexOf("S")};

  int nSplits = 0;
  for (final Set<int> currentRowSplitterIndices in splitterIndicesByRow) {
    for (final int currentSplitterIndex in currentRowSplitterIndices) {
      if (currentBeamIndices.contains(currentSplitterIndex)) {
        nSplits++;
        currentBeamIndices.remove(currentSplitterIndex);
        currentBeamIndices.addAll({
          currentSplitterIndex - 1,
          currentSplitterIndex + 1,
        });
      }
    }
  }

  print(nSplits);
}
