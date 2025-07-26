class AppGenericFailure {
  final String message;
  final String? title;
  final Object? error;
  final StackTrace? stackTrace;

  AppGenericFailure({
    required this.message,
    this.title,
    this.error,
    this.stackTrace,
  });

  @override
  String toString() {
    return 'AppGenericFailure{message: $message, title: $title, error: ${error.toString()}}';
  }
}
