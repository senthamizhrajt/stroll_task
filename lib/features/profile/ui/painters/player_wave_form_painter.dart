import 'package:flutter/material.dart';

class PlayerWaveformPainter extends CustomPainter {
  final List<double> dBFSValues;
  final double maxAmplitude;
  final Color color;
  final Color amplitudeHighlightColor;
  final int activeAmplitudeIndex;

  PlayerWaveformPainter(this.dBFSValues, this.maxAmplitude, this.color, this.activeAmplitudeIndex, this.amplitudeHighlightColor);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paintLine = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    Paint activePaintLine = Paint()
      ..color = amplitudeHighlightColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    Paint paintCenterLine = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    double stepX = 4; // Constant spacing of 2 pixels
    double halfHeight = size.height / 2;
    double totalWidth = size.width;

    canvas.drawLine(Offset((dBFSValues.length * (stepX)), halfHeight), Offset(size.width, halfHeight),  paintCenterLine);
    for (int i = 0; i < dBFSValues.length; i++) {
      if (dBFSValues[i].isInfinite) return;
      double startX = i * stepX; // Calculate startX from right to left
      double startY = halfHeight * (dBFSValues[i] / maxAmplitude);

      double diffToCenter = (halfHeight - startY) / 2;

      startY = startY + diffToCenter;

      double endX = i * stepX; // Calculate endX from right to left
      double endY = halfHeight + diffToCenter;

      //print('drawing $i line, activeIndex: $activeAmplitudeIndex');

      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), activeAmplitudeIndex != -1 && i <= activeAmplitudeIndex ? activePaintLine : paintLine);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
