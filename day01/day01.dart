import 'dart:io';

enum Direction { left, right }

void main() {
  final File file = File("./day01/input");
  final List<String> lines = file.readAsLinesSync();

  int password = 0;

  int currentPos = 50;
  for (String line in lines) {
    final (Direction dir, int count) = parse(line);

    switch (dir) {
      case Direction.left:
        currentPos -= count;

      case Direction.right:
        currentPos += count;
    }

    while (currentPos < 0) {
      currentPos += 100;
    }
    while (currentPos > 99) {
      currentPos -= 100;
    }

    print("$line to $currentPos");

    if (currentPos == 0) {
      password++;
    }
  }

  print(password);
}

(Direction, int) parse(String line) {
  final int count = int.parse(line.substring(1));
  return (line.startsWith("R") ? Direction.right : Direction.left, count);
}
