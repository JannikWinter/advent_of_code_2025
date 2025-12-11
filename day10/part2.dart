import 'dart:io';

import 'package:collection/collection.dart';

void main() {
  final File file = File("./day10/input");
  final int result = solveDay10Part2(file);
  print(result);
}

int solveDay10Part2(File file) {
  final List<String> lines = file.readAsLinesSync();

  int result = 0;
  for (final String line in lines) {
    final [_, ...buttonStrs, joltagesStr] = line.split(" ");

    final List<_Button> buttons = buttonStrs
        .map((buttonStr) => _Button.fromString(buttonStr))
        .toList();

    final _JoltageConfiguration targetJoltage =
        _JoltageConfiguration.fromString(joltagesStr);

    final Set<_JoltageConfiguration> unprocessedJoltages = {
      _JoltageConfiguration(List.filled(targetJoltage.length, 0)),
    };

    int? nPresses;

    outer:
    for (int i = 0; unprocessedJoltages.isNotEmpty; i++) {
      final Set<_JoltageConfiguration> processingJoltages = Set.from(
        unprocessedJoltages,
      );
      unprocessedJoltages.clear();

      for (final _JoltageConfiguration joltage in processingJoltages) {
        if (joltage == targetJoltage) {
          nPresses = i;
          break outer;
        }
        if (joltage > targetJoltage) continue;

        for (final _Button button in buttons) {
          unprocessedJoltages.add(joltage + button);
        }
      }
    }

    assert(nPresses != null);

    print("$joltagesStr: $nPresses");

    result += nPresses!;
  }

  return result;
}

class _Button {
  _Button(Iterable<int> triggeredIndices)
    : _triggeredIndices = Set.from(triggeredIndices);
  _Button.fromString(String buttonString)
    : _triggeredIndices = buttonString
          .substring(1, buttonString.length - 1)
          .split(",")
          .map((idxStr) => int.parse(idxStr))
          .toSet();

  final Set<int> _triggeredIndices;

  @override
  bool operator ==(covariant _Button other) {
    return SetEquality(
      IdentityEquality(),
    ).equals(_triggeredIndices, other._triggeredIndices);
  }

  @override
  int get hashCode => Object.hashAll(_triggeredIndices);
}

class _JoltageConfiguration {
  _JoltageConfiguration(Iterable<int> values) : _values = List.from(values);
  _JoltageConfiguration.fromString(String joltageString)
    : _values = joltageString
          .substring(1, joltageString.length - 1)
          .split(",")
          .map((joltageStr) => int.parse(joltageStr))
          .toList();

  final List<int> _values;

  int get length => _values.length;

  _JoltageConfiguration operator +(_Button button) {
    final List<int> newValues = List.from(_values);
    for (final int index in button._triggeredIndices) {
      newValues[index]++;
    }
    return _JoltageConfiguration(newValues);
  }

  bool operator >(_JoltageConfiguration other) {
    assert(length == other.length);
    for (int i = 0; i < _values.length; i++) {
      if (_values[i] <= other._values[i]) return false;
    }

    return true;
  }

  bool operator <(_JoltageConfiguration other) {
    assert(length == other.length);
    for (int i = 0; i < _values.length; i++) {
      if (_values[i] >= other._values[i]) return false;
    }
    return true;
  }

  @override
  bool operator ==(covariant _JoltageConfiguration other) {
    return ListEquality(IdentityEquality()).equals(_values, other._values);
  }

  @override
  int get hashCode => Object.hashAll(_values);
}
