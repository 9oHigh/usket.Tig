extension NullableX<T> on T {
  R? let<R>(R Function(T value) operation) => operation(this);
}
