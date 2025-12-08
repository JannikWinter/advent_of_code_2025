import 'dart:io';
import 'dart:math';

void main() {
  final File file = File("./day08/input");
  final int result = solveDay8Part1(file, 1000);
  print(result);
}

int solveDay8Part1(File file, int nConnections) {
  final List<String> lines = file.readAsLinesSync();

  final List<_Position> points = lines.map((line) {
    final [x, y, z] = line.split(",").map((str) => int.parse(str)).toList();
    return _Position(x, y, z);
  }).toList();

  final Set<(int, int)> connections = {};
  final Map<int, int> pointIdxToCircuitId = {
    for (int i = 0; i < points.length; i++) i: i,
  };
  final Map<int, Set<int>> circuitIdToPointIndices = {
    for (int i = 0; i < points.length; i++) i: {pointIdxToCircuitId[i]!},
  };

  for (int n = 0; n < nConnections; n++) {
    int closestIndexA = -1;
    int closestIndexB = -1;
    double closestDistance = double.infinity;

    for (int a = 0; a < points.length; a++) {
      for (int b = a + 1; b < points.length; b++) {
        if (connections.contains((a, b))) continue;

        double distance = points[a].distance(points[b]);
        if (distance <= closestDistance) {
          closestDistance = distance;
          closestIndexA = a;
          closestIndexB = b;
        }
      }
    }

    connections.add((closestIndexA, closestIndexB));

    if (pointIdxToCircuitId[closestIndexA] ==
        pointIdxToCircuitId[closestIndexB]) {
      continue;
    }

    final int circuitIdA = pointIdxToCircuitId[closestIndexA]!;
    final int circuitIdB = pointIdxToCircuitId[closestIndexB]!;

    for (final connectedPointIndex in circuitIdToPointIndices[circuitIdB]!) {
      pointIdxToCircuitId[connectedPointIndex] = circuitIdA;
    }
    circuitIdToPointIndices[circuitIdA]!.addAll(
      circuitIdToPointIndices[circuitIdB]!,
    );
    circuitIdToPointIndices.remove(circuitIdB);
  }

  final List<int> circuitSizes = circuitIdToPointIndices.values
      .map((circuit) => circuit.length)
      .where((size) => size > 0)
      .toList();
  circuitSizes.sort((a, b) => b.compareTo(a));

  final int result = circuitSizes
      .take(3)
      .reduce((value, element) => value * element);

  return result;
}

class _Position {
  const _Position(this.x, this.y, this.z);

  final int x;
  final int y;
  final int z;

  _Position operator +(_Position other) {
    return _Position(x + other.x, y + other.y, z + other.z);
  }

  _Position operator -(_Position other) {
    return _Position(x - other.x, y - other.y, z - other.z);
  }

  _Position operator *(int scalar) {
    return _Position(x * scalar, y * scalar, z * scalar);
  }

  double distance(_Position other) {
    final diff = this - other;

    return sqrt(diff.x * diff.x + diff.y * diff.y + diff.z * diff.z);
  }

  @override
  operator ==(covariant _Position other) {
    return x == other.x && y == other.y && z == other.z;
  }

  @override
  int get hashCode => Object.hash(x, y, z);

  @override
  String toString() {
    return "($x, $y, $z)";
  }
}
