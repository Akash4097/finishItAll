import 'package:talker_flutter/talker_flutter.dart';

import 'logger.dart';

class AppLogger implements Logger {
  AppLogger._init();

  static final AppLogger _instance = AppLogger._init();
  final _logger = TalkerFlutter.init(
    settings: TalkerSettings(),
    logger: _CustomTalkerLogger(TalkerSettings()),
  );

  factory AppLogger.init() => _instance;

  @override
  void debug(Object object, String message) {
    _logger.debug(
      "${object.toString()} || $message",
    );
  }

  @override
  void error(Object object, String message, [Exception? exception]) {
    _logger.error("${object.toString()} || $message");
  }

  @override
  void info(Object object, String message) {
    _logger.info("${object.toString()} || $message");
  }

  @override
  void warning(Object object, String message) {
    _logger.warning("${object.toString()} || $message");
  }
}

class _CustomTalkerLogger extends TalkerLogger {
  _CustomTalkerLogger(TalkerSettings settings) : super();

  @override
  void log(msg, {LogLevel? level, AnsiPen? pen}) {
    final filename = _getFilename();
    final customMessage = '[$filename] $msg';
    super.log(customMessage, level: level, pen: pen);
  }

  String _getFilename() {
    // Use StackTrace to get the filename
    final stackTrace = StackTrace.current;
    final frames = stackTrace.toString().split('\n');
    if (frames.length > 1) {
      final frame = frames[1];
      final match = RegExp(r'(\w+\.dart)').firstMatch(frame);
      if (match != null) {
        return match.group(1) ?? 'unknown';
      }
    }
    return 'unknown';
  }
}
