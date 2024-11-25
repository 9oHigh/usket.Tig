extension IntExtensions on int {
  int? takeIf(bool Function(int value) condition) =>
      condition(this) ? this : null;
}