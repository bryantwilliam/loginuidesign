import 'package:flutter/material.dart';

class EnterAnimation {
  late final Animation<double> circleSize;

  EnterAnimation(AnimationController controller) {
    circleSize = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutBack,
      ),
    );
  }
}
