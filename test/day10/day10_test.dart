import 'dart:io';

import 'package:test/test.dart';

import '../../day10/part1.dart';
import '../../day10/part2.dart';

void main() {
  final File testFile = File("./test/day10/test_input");
  group("Day 10", () {
    test("Day 10, Part 1", () {
      expect(solveDay10Part1(testFile), 7);
    });
    test("Day 10, Part 2", () {
      expect(solveDay10Part2(testFile), 33);
    });
  });
}
