import 'package:flutter/material.dart';
// import 'dart:math';

class AnimatedTreePainter extends StatefulWidget {
  final int growthStage;

  const AnimatedTreePainter({super.key, required this.growthStage});

  @override
  State<AnimatedTreePainter> createState() => _AnimatedTreePainterState();
}

class _AnimatedTreePainterState extends State<AnimatedTreePainter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedTreePainter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.growthStage != widget.growthStage) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: TreePainter(widget.growthStage, _animation.value),
        );
      },
    );
  }
}

class TreePainter extends CustomPainter {
  final int growthStage;
  final double animationProgress;

  TreePainter(this.growthStage, this.animationProgress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final centerX = size.width / 2;
    final baseY = size.height * 0.9;
    final treeHeight = size.height * 0.6 * animationProgress;

    paint.color = Colors.brown;
    canvas.drawLine(
      Offset(centerX, baseY),
      Offset(centerX, baseY - treeHeight),
      paint,
    );

    final leafPaint = Paint()
      ..color = Colors.green.shade600.withOpacity(animationProgress);
    if (growthStage >= 1) {
      final radius = 20.0 * animationProgress;
      canvas.drawCircle(Offset(centerX, baseY - treeHeight), radius, leafPaint);
    }
    if (growthStage >= 2) {
      final radius = 30.0 * animationProgress;
      canvas.drawCircle(
          Offset(centerX - 20, baseY - treeHeight + 20), radius, leafPaint);
      canvas.drawCircle(
          Offset(centerX + 20, baseY - treeHeight + 20), radius, leafPaint);
    }
    if (growthStage >= 3) {
      final radius = 40.0 * animationProgress;
      canvas.drawCircle(
          Offset(centerX, baseY - treeHeight - 30), radius, leafPaint);
    }
  }

  @override
  bool shouldRepaint(TreePainter oldDelegate) {
    return oldDelegate.growthStage != growthStage ||
        oldDelegate.animationProgress != animationProgress;
  }
}
