import 'package:flutter/material.dart';

class Helpers {
  static FixedScrollBehavior get fixedScrollBehavior => FixedScrollBehavior();
}

class FixedScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}