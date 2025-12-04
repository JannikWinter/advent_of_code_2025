import 'dart:io';

enum Direction { left, right }

void main() {
  final File file = File("./day01/input");
  final List<String> lines = file.readAsLinesSync();

  int nClicks = 0;

  int currentPos = 50;
  int previousPos;
  for (String line in lines) {
    var (Direction dir, int count) = parse(line);

    while (count > 99) {
      count -= 100;
      nClicks++;
    }

    previousPos = currentPos;

    switch (dir) {
      case Direction.left:
        currentPos -= count;
        if (currentPos == 0) {
          nClicks++;
        } else if (currentPos < 0) {
          currentPos += 100;
          if (previousPos != 0) {
            nClicks++;
          }
        }

      case Direction.right:
        currentPos += count;
        if (currentPos > 99) {
          currentPos -= 100;
          nClicks++;
        }
    }

    print("$previousPos + $line -> $currentPos ($nClicks)");
  }

  print("Password: $nClicks");
}

(Direction, int) parse(String line) {
  final int count = int.parse(line.substring(1));
  return (line.startsWith("R") ? Direction.right : Direction.left, count);
}
