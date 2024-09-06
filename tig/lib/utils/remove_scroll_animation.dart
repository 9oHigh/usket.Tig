import 'package:flutter/material.dart';

// MARK: - 스크롤시 안드로이드 애니메이션 제거 클래스
class RemoveScrollAnimation extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
