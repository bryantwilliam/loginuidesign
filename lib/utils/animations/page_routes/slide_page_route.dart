import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget child;

  SlidePageRoute(this.child)
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (BuildContext context_,
              Animation<double> animation1,
              Animation<double> animation2,
              Widget child_) {
            var animation = Tween<Offset>(
              begin: const Offset(1, 0),
              end: const Offset(0, 0),
            ).animate(animation1);
            return SlideTransition(position: animation, child: child_);
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
