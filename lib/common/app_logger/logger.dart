abstract interface class Logger {
  void debug(Object object, String message);
  void info(Object object, String message);
  void warning(Object object, String message);
  void error(Object object, String message, [Exception? exception]);
}
