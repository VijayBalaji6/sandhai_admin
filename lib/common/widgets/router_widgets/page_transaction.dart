import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum PageSlideTransition { left, top, bottom, right }

class SlideTransactionPage {
  static Page<T> buildSlideTransitionPage<T>({
    required Widget child,
    PageSlideTransition slideDirection =
        PageSlideTransition.right, // Default direction
  }) {
    // Determine the begin offset based on the direction
    Offset beginOffset;

    switch (slideDirection) {
      case PageSlideTransition.left:
        beginOffset = const Offset(-1.0, 0.0);
        break;
      case PageSlideTransition.top:
        beginOffset = const Offset(0.0, -1.0);
        break;
      case PageSlideTransition.bottom:
        beginOffset = const Offset(0.0, 1.0);
        break;
      case PageSlideTransition.right:
        beginOffset = const Offset(1.0, 0.0);
    }

    return CustomTransitionPage<T>(
      child: child,
      transitionDuration: const Duration(milliseconds: 350),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: beginOffset,
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          ),
          child: child,
        );
      },
    );
  }
}
