// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:math';

import '../util.dart';

void main() {
  final File file = File("./day10/input");
  final int result = solveDay10Part1(file);
  print(result);
}

int solveDay10Part1(File file) {
  final List<String> lines = file.readAsLinesSync();

  int result = 0;
  for (final String line in lines) {
    final [lightStr, ...buttonStrs, joltageStr] = line.split(" ");

    final int targetLightValue = int.parse(
      lightStr
          .substring(1, lightStr.length - 1)
          .chars
          .toList()
          .reversed
          .map((c) => c == "#" ? "1" : "0")
          .join(""),
      radix: 2,
    );

    final Set<int> buttonValues = buttonStrs.map((buttonStr) {
      final Set<int> buttonTargetIndices = buttonStr
          .substring(1, buttonStr.length - 1)
          .split(",")
          .map((idxStr) => int.parse(idxStr))
          .toSet();
      int buttonValue = 0;
      for (final int buttonTargetIndex in buttonTargetIndices) {
        buttonValue += pow(2, buttonTargetIndex).toInt();
      }
      return buttonValue;
    }).toSet();

    final Map<int, int> targetLightConfig_nPresses = {
      0: 0,
      for (final int buttonValue in buttonValues) buttonValue: 1,
    };

    for (
      int i = 1;
      i < buttonValues.length &&
          !targetLightConfig_nPresses.containsKey(targetLightValue);
      i++
    ) {
      final Set<int> unprocessedButtons = targetLightConfig_nPresses.entries
          .where((entry) => entry.value == i)
          .map((entry) => entry.key)
          .toSet();

      final otherButtons = targetLightConfig_nPresses.entries
          .where((entry) => entry.value <= i)
          .toSet();

      for (final int button in unprocessedButtons) {
        for (final entry in otherButtons) {
          final int resultingLightConfig = button ^ entry.key;
          final int resultingNPresses = entry.value + i;

          if (!targetLightConfig_nPresses.containsKey(resultingLightConfig) ||
              targetLightConfig_nPresses[resultingLightConfig]! >
                  resultingNPresses) {
            targetLightConfig_nPresses[resultingLightConfig] =
                resultingNPresses;
          }
        }
      }
    }

    final int nMinPresses = targetLightConfig_nPresses[targetLightValue]!;

    print("$lightStr: $nMinPresses");

    result += nMinPresses;
  }

  return result;
}
