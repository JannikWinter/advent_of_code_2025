import 'dart:io';

import 'package:test/test.dart';

import '../../day01/part1.dart';
import '../../day01/part2.dart';

void main() {
  final File testFile = File("./test/day01/test_input");
  group("Day  1", () {
    test("Day  1, Part 1", () {
      expect(solveDay1Part1(testFile), 3);
    });
    test("Day  1, Part 2", () {
      expect(solveDay1Part2(testFile), 6);
    });
  });
}
