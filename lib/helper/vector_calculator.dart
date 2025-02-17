import 'dart:math';

abstract class VectorCalculator {
  static double getLength({Point from = const Point(0, 0), required Point to}) {
    return sqrt(pow(to.x - from.x, 2) + pow(to.y - from.y, 2));
  }

  static double getDirection({Point from = const Point(0, 0), required Point to}) {
    if (to.x == from.x) {
      return (to.y - from.y).sign * pi / 2;
    }
    return atan((to.y - from.y) / (to.x - from.x));
  }
}

extension VectorCalculatorExtension on Point<double> {
  Point<double> move(num x, num y) {
    return Point(x + this.x, y + this.y);
  }

  Point<double> moveRP(num length, num direction) {
    return move(length * cos(direction), length * sin(direction));
  }
}