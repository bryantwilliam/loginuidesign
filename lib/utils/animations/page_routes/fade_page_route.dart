import 'package:flutter/material.dart';

class FadePageRoute extends PageRouteBuilder {
  final Widget child;

  FadePageRoute(this.child)
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (BuildContext context_,
              Animation<double> animation1,
              Animation<double> animation2,
              Widget child_) {
            return FadeTransition(opacity: animation1, child: child_);
          },
          pageBuilder: (
            BuildContext context_,
            Animation<double> animation1,
            Animation<double> animation2,
          ) {
            return child;
          },
        );
}
