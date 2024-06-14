import 'dart:async';

class ActivityTimeTracker {
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  Duration _remaining;
  bool _isRunning = false;
  final Function onTimeUp;

  ActivityTimeTracker(Duration totalDuration, this.onTimeUp)
      : _remaining = totalDuration;

  void start() {
    if (_isRunning) return;
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapsed += const Duration(seconds: 1);
      _remaining -= const Duration(seconds: 1);
      if (_remaining <= Duration.zero) {
        _dispose();
        onTimeUp();
      }
    });
  }

  void pause() {
    if (!_isRunning) return;
    _isRunning = false;
    _timer?.cancel();
  }

  void resume() {
    if (_isRunning) return;
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapsed += const Duration(seconds: 1);
      _remaining -= const Duration(seconds: 1);
      if (_remaining <= Duration.zero) {
        _dispose();
        onTimeUp();
      }
    });
  }

//   import 'package:flutter_test/flutter_test.dart';
// import 'package:your_app/timer/activity_timmer.dart';

// void main() {
//   group('ActivityTimmer', () {
//     test('start timer', () {
//       final timer = ActivityTimmer();
//       timer.start();
//       expect(timer.isRunning, isTrue);
//     });

//     test('stop timer', () {
//       final timer = ActivityTimmer();
//       timer.start();
//       timer.stop();
//       expect(timer.isRunning, isFalse);
//     });

//     test('reset timer', () {
//       final timer = ActivityTimmer();
//       timer.start();
//       timer.reset();
//       expect(timer.isRunning, isFalse);
//       expect(timer.elapsedTime, Duration.zero);
//     });

//     test('elapsed time increases while running', () async {
//       final timer = ActivityTimmer();
//       timer.start();
//       final startTime = timer.elapsedTime;
//       await Future.delayed(const Duration(milliseconds: 100));
//       expect(timer.elapsedTime, greaterThan(startTime));
//     });

//     test('elapsed time does not increase after stopping', () async {
//       final timer = ActivityTimmer();
//       timer.start();
//       await Future.delayed(const Duration(milliseconds: 100));
//       final elapsedTime = timer.elapsedTime;
//       timer.stop();
//       await Future.delayed(const Duration(milliseconds: 100));
//       expect(timer.elapsedTime, equals(elapsedTime));
//     });
//   });
// }

  void close() {
    _dispose();
  }

  void _dispose() {
    _isRunning = false;
    _timer?.cancel();
    _timer = null;
  }

  Duration get elapsed => _elapsed;
  Duration get remaining => _remaining;
  bool get isRunning => _isRunning;
}
