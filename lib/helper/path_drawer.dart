import 'dart:math';

import 'package:chart_components/helper/vector_calculator.dart';
import 'package:flutter/material.dart';

extension PathDrawer on Path {
  void addLine({
    double? fromX,
    double? fromY,
    required double toX,
    required double toY,
  }) {
    assert(
      !((fromX != null) ^ (fromY != null)),
      "You must specify all 2 directions or none of them.",
    );
    if (toX == fromX && toY == fromY) return;
    if (fromX != null) moveTo(fromX, fromY!);
    lineTo(toX, toY);
  }

  void addDashLine({
    double fromX = 0,
    double fromY = 0,
    required double toX,
    required double toY,
    double dashLength = 10,
    double dashSpacing = 10,
    double dashRelativeOffset = 0,
  }) {
    assert(
      0 <= dashRelativeOffset && dashRelativeOffset <= 1,
      "Dash Relative Offset must be in range [0, 1]",
    );
    if (toX == fromX && toY == fromY) return;
    moveTo(fromX, fromY);

    final length = VectorCalculator.getLength(
      from: Point(fromX, fromY),
      to: Point(toX, toY),
    );
    final direction = VectorCalculator.getDirection(
      from: Point(fromX, fromY),
      to: Point(toX, toY),
    );
    double curr = 0;
    Point<double> currentPoint = Point(fromX, fromY);

    double realDashLength = min(length, dashLength);
    double firstDashLength = realDashLength * (1 - dashRelativeOffset);
    double realDashSpacing = min(length, dashSpacing);

    // Draw first dash
    currentPoint = currentPoint.moveRP(firstDashLength, direction);
    addLine(
      fromX: fromX,
      fromY: fromY,
      toX: currentPoint.x,
      toY: currentPoint.y,
    );
    curr += firstDashLength;

    // Draw spacing and remaining dash
    bool isSpacing = true;
    while (curr <= length) {
      final drawLength = isSpacing ? realDashSpacing : realDashLength;
      currentPoint = currentPoint.moveRP(drawLength, direction);
      curr += drawLength;
      if (curr > length) {
        currentPoint = Point(toX, toY);
      }
      (isSpacing ? moveTo : lineTo)(
        currentPoint.x,
        currentPoint.y,
      );
      isSpacing = !isSpacing;
    }
  }
}
