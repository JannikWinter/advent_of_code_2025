import 'dart:io';

void main() {
  final File file = File("./day11/input");
  final int result = solveDay11Part1(file);
  print(result);
}

int solveDay11Part1(File file) {
  final List<String> lines = file.readAsLinesSync();

  final Map<String, Set<String>> allForwardPaths = {};
  final Map<String, Set<String>> allBackwardsPaths = {};

  for (final String line in lines) {
    final [start, after] = line.split(": ");

    final Set<String> nextElements = after.split(" ").toSet();

    assert(!allForwardPaths.containsKey(start));
    allForwardPaths[start] = nextElements;

    for (final String next in nextElements) {
      if (!allBackwardsPaths.containsKey(next)) {
        allBackwardsPaths[next] = {};
      }
      allBackwardsPaths[next]!.add(start);
    }
  }

  final Set<String> allElementsReachableFromYou = {};
  {
    final List<String> unprocessedElements = [...allForwardPaths["you"]!];
    while (unprocessedElements.isNotEmpty) {
      final String currentElement = unprocessedElements.removeAt(0);

      if (!allElementsReachableFromYou.contains(currentElement)) {
        allElementsReachableFromYou.add(currentElement);
        if (currentElement != "out") {
          unprocessedElements.addAll(allForwardPaths[currentElement]!);
        }
      }
    }
  }

  assert(allElementsReachableFromYou.contains("out"));

  final Set<String> allElementsReachingOut = {};
  {
    final List<String> unprocessedElements = [...allBackwardsPaths["out"]!];
    while (unprocessedElements.isNotEmpty) {
      final String currentElement = unprocessedElements.removeAt(0);

      if (!allElementsReachingOut.contains(currentElement)) {
        allElementsReachingOut.add(currentElement);
        final Set<String>? currentBackwardsPaths =
            allBackwardsPaths[currentElement];
        if (currentBackwardsPaths != null && currentBackwardsPaths.isNotEmpty) {
          unprocessedElements.addAll(currentBackwardsPaths);
        }
      }
    }
  }

  final Set<String> allElementsBetweenStartAndOut = {
    "you",
    "out",
    ...allElementsReachableFromYou.intersection(allElementsReachingOut),
  };

  allForwardPaths.removeWhere(
    (key, value) => !allElementsBetweenStartAndOut.contains(key),
  );
  for (final Set<String> forwardPaths in allForwardPaths.values) {
    forwardPaths.removeWhere(
      (elem) => !allElementsBetweenStartAndOut.contains(elem),
    );
  }
  allBackwardsPaths.removeWhere(
    (key, value) => !allElementsBetweenStartAndOut.contains(key),
  );
  for (final Set<String> backwardsPaths in allBackwardsPaths.values) {
    backwardsPaths.removeWhere(
      (elem) => !allElementsBetweenStartAndOut.contains(elem),
    );
  }

  int nPossiblePaths = _getNPossiblePathsTo(
    "out",
    backwardPaths: allBackwardsPaths,
    cache: {},
  );

  return nPossiblePaths;
}

int _getNPossiblePathsTo(
  String element, {
  required Map<String, Set<String>> backwardPaths,
  required Map<String, int> cache,
}) {
  if (element == "you") return 1;
  if (cache.containsKey(element)) return cache[element]!;

  int nPossiblePaths = 0;
  for (final String prevElement in backwardPaths[element]!) {
    nPossiblePaths += _getNPossiblePathsTo(
      prevElement,
      backwardPaths: backwardPaths,
      cache: cache,
    );
  }

  cache[element] = nPossiblePaths;
  return nPossiblePaths;
}
