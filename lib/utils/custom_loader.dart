import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;

  CustomCircularProgressIndicator({
    this.color = const Color.fromRGBO(110, 42, 127, 1),
    this.size = 50.0,
    this.duration = const Duration(seconds: 2),
  });

  @override
  _CustomCircularProgressIndicatorState createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.repeat(reverse: true);
    _sizeAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2.0 * 3.141592653589793,
            child: Container(
                width: widget.size * _sizeAnimation.value,
                height: widget.size * _sizeAnimation.value,
                child: CircularProgressIndicator(
                  color: widget.color,
                )),
          );
        },
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Color color;
  CirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 -
        3; // Adjust to create the desired thickness of the circle

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
