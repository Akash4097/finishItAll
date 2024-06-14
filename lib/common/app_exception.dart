abstract class AppException implements Exception {}

class TaskDueDateException extends AppException {
  final String message;
  final Exception? innerException;
  final StackTrace? stackTrace;

  TaskDueDateException(this.message, [this.innerException, this.stackTrace]);

  @override
  String toString() {
    var message = 'TaskDueDateException: $this.message';
    if (innerException != null) {
      message += '\nInner Exception: $innerException';
    }
    if (stackTrace != null) {
      message += '\nStack Trace: $stackTrace';
    }
    return message;
  }
}
