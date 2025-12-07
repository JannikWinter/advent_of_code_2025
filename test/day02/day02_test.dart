import 'dart:io';

import 'package:test/test.dart';

import '../../day02/part1.dart';
import '../../day02/part2.dart';

void main() {
  final File testFile = File("./test/day02/test_input");
  group("Day  2", () {
    test("Day  2, Part 1", () {
      expect(solveDay2Part1(testFile), 1227775554);
    });
    test("Day  2, Part 2", () {
      expect(solveDay2Part2(testFile), 4174379265);
    });
  });
}
