/// Base class for domain use cases.
abstract class UseCase<T, P> {
  Future<T> call(P params);
}
