import 'dart:io';

void main() {
  final File file = File("./day09/input");
  final int result = solveDay9Part1(file);
  print(result);
}

int solveDay9Part1(File file) {
  final List<(int, int)> points = file.readAsLinesSync().map((line) {
    final [x, y] = line.split(",");
    return (int.parse(x), int.parse(y));
  }).toList();

  int largestArea = 0;

  for (int a = 0; a < points.length; a++) {
    final pointA = points[a];
    for (int b = a + 1; b < points.length; b++) {
      final pointB = points[b];

      final int diffX = (pointA.$1 - pointB.$1).abs() + 1;
      final int diffY = (pointA.$2 - pointB.$2).abs() + 1;

      final int area = diffX * diffY;
      if (area > largestArea) {
        largestArea = area;
      }
    }
  }

  return largestArea;
}
