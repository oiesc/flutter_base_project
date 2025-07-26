class ApplicationError {
  final String message;
  final Object? error;
  final StackTrace? stackTrace;

  const ApplicationError({
    required this.message,
    this.error,
    this.stackTrace,
  });
}