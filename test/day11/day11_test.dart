import 'dart:io';

import 'package:test/test.dart';

import '../../day11/part1.dart';
import '../../day11/part2.dart';

void main() {
  final File testFile = File("./test/day11/test_input");
  group("Day 11", () {
    test("Day 11, Part 1", () {
      expect(solveDay11Part1(testFile), 5);
    });
    test("Day 11, Part 2", () {
      expect(solveDay11Part2(testFile), false);
    });
  });
}
