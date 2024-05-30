import 'package:talker_flutter/talker_flutter.dart';
import 'logger.dart';

class AppLogger implements Logger {
  final Type type;

  AppLogger._init(this.type) {
    _logger = TalkerFlutter.init(
        logger: _CustomTalkerLogger(type), settings: TalkerSettings());
  }

  static AppLogger? _instance;
  late final Talker _logger;

  factory AppLogger.init(Type type) {
    _instance ??= AppLogger._init(type);

    return _instance!;
  }

  @override
  void debug(String message) {
    _logger.debug(message);
  }

  @override
  void error(String message, [Exception? exception]) {
    _logger.error(message, exception);
  }

  @override
  void info(String message) {
    _logger.info(message);
  }

  @override
  void warning(String message) {
    _logger.warning(message);
  }

  @override
  void severe(String message, [Exception? exception]) {
    _logger.critical(message, exception);
  }
}

class _CustomTalkerLogger extends TalkerLogger {
  final Type type;
  _CustomTalkerLogger(this.type) : super();

  @override
  void log(msg, {LogLevel? level, AnsiPen? pen}) {
    final customMsg = "$type || $msg";
    super.log(customMsg, level: level, pen: pen);
  }
}
