import 'dart:io';

import 'package:test/test.dart';

import '../../day09/part1.dart';
import '../../day09/part2.dart';

void main() {
  final File testFile = File("./test/day09/test_input");
  group("Day  9", () {
    test("Day  9, Part 1", () {
      expect(solveDay9Part1(testFile), 50);
    });
    test("Day  9, Part 2", () {
      expect(solveDay9Part2(testFile), 24);
    });
  });
}
