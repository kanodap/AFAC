import 'package:flutter/material.dart';

/// 간단한 '잉크 흐름' 애니메이션 위젯 예시
class AnimatedInkFlow extends StatefulWidget {
  const AnimatedInkFlow({Key? key}) : super(key: key);

  @override
  _AnimatedInkFlowState createState() => _AnimatedInkFlowState();
}

class _AnimatedInkFlowState extends State<AnimatedInkFlow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 3초 주기로 반복(reverse 없이 계속) 애니메이션
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(); // 계속 반복
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AnimatedBuilder를 통해 _controller.value (0.0 ~ 1.0)가 바뀔 때마다
    // CustomPaint를 다시 그려 애니메이션을 표현
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: InkDripPainter(_controller.value),
          // 화면 전체를 덮고 싶으면 MediaQuery나 부모 사이즈를 사용
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
          ),
        );
      },
    );
  }
}

/// 실제로 드립 모양을 그리는 Painter
class InkDripPainter extends CustomPainter {
  final double progress; // 0.0 ~ 1.0 사이를 애니메이션 값으로 사용

  InkDripPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    // 잉크 색상 (테마에 맞춰 변경 가능)
    final paint = Paint()..color = Color(0xff155e24);

    // 간단한 데모용 Path (잉크가 위에서 아래로 흐르는 모양)
    final path = Path();

    // 상단 라인
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);

    // 아래로 잉크가 내려오는 높이
    final dripHeight = size.height * 0.2 + (size.height * 1 * progress);

    // 오른쪽에서 왼쪽으로 곡선을 그려서 잉크가 떨어지는 느낌
    path.lineTo(size.width, dripHeight);
    path.quadraticBezierTo(
      size.width * 0.5, // 중간 지점 x
      dripHeight + 50 * (1 - progress), // 곡률
      0, // 끝 지점 x
      dripHeight, // 끝 지점 y
    );

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(InkDripPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class DripPainter extends CustomPainter {
  final double progress; // 0.0 ~ 1.0, 애니메이션 진행도

  DripPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;
    final path = Path();

    // (예시) 텍스트 하단부 기준으로 드립 시작
    // progress에 따라 Path를 늘려서 "뚝뚝" 떨어지는 모양으로
    // path.moveTo(...);
    // path.cubicTo(...); // etc.

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant DripPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}


