import 'package:ecommerce_app/config/theme/my_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../controllers/splash_controller.dart';
import 'widgets/AnimatedInkFlow.dart';


class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    var theme = context.theme;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // 배경 잉크 애니메이션 위젯
            const AnimatedInkFlow(),
            // 중앙에 "STCKY" 텍스트
            Center(
              child: Text(
                'STCKY',
                style: TextStyle(
                  fontFamily: 'StickyFont',  // 커스텀 폰트 적용
                  fontSize: 80.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      offset: const Offset(2, 2),
                      blurRadius: 6,
                      color: Colors.black45,
                    ),
                  ],
                ),
              ).animate().fade(duration: 500.ms),
            ),
          ],
        ),
      ),
    );
  }
}
