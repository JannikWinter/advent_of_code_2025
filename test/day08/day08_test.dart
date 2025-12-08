import 'dart:io';

import 'package:test/test.dart';

import '../../day08/part1.dart';
import '../../day08/part2.dart';
// import '../../day08/part2.dart';

void main() {
  final File testFile = File("./test/day08/test_input");
  group("Day  8", () {
    test("Day  8, Part 1", () {
      expect(solveDay8Part1(testFile, 10), 40);
    });
    test("Day  8, Part 2", () {
      expect(solveDay8Part2(testFile), 25272);
    });
  });
}
