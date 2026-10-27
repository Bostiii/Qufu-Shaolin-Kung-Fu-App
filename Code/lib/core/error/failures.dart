/// Base class for errors that cross layer boundaries (data -> domain -> presentation).
abstract class Failure {
  const Failure(this.message);
  final String message;
}
