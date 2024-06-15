import 'dart:async';

class ActivityTimeTracker {
  static const Duration _oneSecond = Duration(seconds: 1);

  Timer? _timer;
  Duration _elapsed = Duration.zero;
  Duration _remaining;
  bool _isRunning = false;
  final Function onTimeUp;
  late final Duration _totalTime;

  ActivityTimeTracker(Duration totalDuration, this.onTimeUp)
      : _remaining = totalDuration,
        _totalTime = totalDuration;

  void start() {
    if (_isRunning) return;
    _isRunning = true;
    _timer = Timer.periodic(_oneSecond, _handleTimerTick);
  }

  void _handleTimerTick(Timer timer) {
    _elapsed += _oneSecond;
    _remaining -= _oneSecond;
    if (_remaining <= Duration.zero) {
      _dispose();
      onTimeUp();
    }
  }

  void pause() {
    if (!_isRunning) return;
    _isRunning = false;
    _timer?.cancel();
  }

  void resume() {
    if (_isRunning) return;
    _isRunning = true;
    _timer = Timer.periodic(_oneSecond, _handleTimerTick);
  }

  void close() {
    _dispose();
  }

  void reset([Duration? newDuration]) {
    _dispose();
    _elapsed = Duration.zero;
    _remaining = newDuration ?? _totalTime;
  }

  void _dispose() {
    _isRunning = false;
    _timer?.cancel();
    _timer = null;
  }

  Duration get elapsedTime => _elapsed;
  Duration get remainingTime => _remaining;
  bool get isRunning => _isRunning;
}
