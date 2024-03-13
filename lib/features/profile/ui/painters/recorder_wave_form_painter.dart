import 'package:flutter/material.dart';

class RecorderWaveformPainter extends CustomPainter {
  final List<double> dBFSValues;
  final double maxAmplitude;
  final Color color;

  RecorderWaveformPainter(this.dBFSValues, this.maxAmplitude, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paintLine = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    Paint paintCenterLine = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    double stepX = 4; // Constant spacing of 2 pixels
    double halfHeight = size.height / 2;
    double totalWidth = size.width;

    canvas.drawLine(Offset(0, halfHeight), Offset(size.width - (dBFSValues.length * stepX), halfHeight), paintCenterLine);

    for (int i = dBFSValues.length - 1; i >= 0; i--) {
      if (dBFSValues[i].isInfinite) return;
      double startX = totalWidth - (dBFSValues.length - 1 - i) * stepX; // Calculate startX from right to left
      double startY = halfHeight * (dBFSValues[i] / maxAmplitude);

      double diffToCenter = (halfHeight - startY) / 2;

      startY = startY + diffToCenter;

      double endX = totalWidth - (dBFSValues.length - 1 - i) * stepX; // Calculate endX from right to left
      double endY = halfHeight + diffToCenter;

      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paintLine);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
