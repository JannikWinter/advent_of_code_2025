import 'dart:io';

import '../util.dart';

void main() {
  File file = File("./day05/input");
  String input = file.readAsStringSync();

  final [idRangesStr, _] = input.split("\n\n");

  final List<(int, int)> idRanges = idRangesStr.split("\n").map((rangeStr) {
    final [startStr, endStr] = rangeStr.split("-");
    return (int.parse(startStr), int.parse(endStr));
  }).toList();

  print("start");

  final Set<(int, int)> mergedRanges = {};
  for (final range in idRanges) {
    final Set<(int, int)> overlappingRanges = mergedRanges
        .where(
          (mRange) =>
              (mRange.$1 <= range.$1 && mRange.$2 >= range.$1) ||
              (range.$1 <= mRange.$1 && range.$2 >= mRange.$1),
        )
        .toSet();

    if (overlappingRanges.isEmpty) {
      mergedRanges.add(range);
      print("adding new range $range");
      continue;
    }

    int newRangeStart = maxInteger;
    int newRangeEnd = 0;
    for (final overlappingRange in {range, ...overlappingRanges}) {
      if (overlappingRange.$1 < newRangeStart) {
        newRangeStart = overlappingRange.$1;
      }
      if (overlappingRange.$2 > newRangeEnd) {
        newRangeEnd = overlappingRange.$2;
      }
    }

    print(
      "merging ${{...overlappingRanges, range}} to ${(newRangeStart, newRangeEnd)}",
    );

    mergedRanges.removeAll(overlappingRanges);
    mergedRanges.add((newRangeStart, newRangeEnd));
  }

  int result = 0;
  for (final range in mergedRanges) {
    result += range.$2 - range.$1 + 1;
  }

  print(result);
}


// 322236233175986 too low
// 365985761267254 too high