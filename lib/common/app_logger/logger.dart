abstract interface class Logger {
  void debug(String message);
  void info(String message);
  void warning(String message);
  void error(String message, [Exception? exception]);
}
