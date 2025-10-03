extension FutureExtensions<T> on Future<T> {
  Future<void> get discardValue => then<void>((_) => null);
}
