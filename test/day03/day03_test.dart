import 'dart:io';

import 'package:test/test.dart';

import '../../day03/part1.dart';
import '../../day03/part2.dart';

void main() {
  final File testFile = File("./test/day03/test_input");
  group("Day  3", () {
    test("Day  3, Part 1", () {
      expect(solveDay3Part1(testFile), 357);
    });
    test("Day  3, Part 2", () {
      expect(solveDay3Part2(testFile), 3121910778619);
    });
  });
}
