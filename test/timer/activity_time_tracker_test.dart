import 'package:finish_it_all/timer/activity_time_tracker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ActivityTimeTracker', () {
    test('start timer', () {
      final timer = ActivityTimeTracker(const Duration(seconds: 5), () {});
      timer.start();
      expect(timer.isRunning, isTrue);
    });

    test('pause timer', () {
      final timer = ActivityTimeTracker(const Duration(seconds: 5), () {});
      timer.start();
      timer.pause();
      expect(timer.isRunning, isFalse);
    });

    test('resume timer', () {
      final timer = ActivityTimeTracker(const Duration(seconds: 5), () {});
      timer.start();
      timer.pause();
      timer.resume();
      expect(timer.isRunning, isTrue);
    });

    test('reset timer', () {
      final timer = ActivityTimeTracker(const Duration(seconds: 5), () {});
      timer.start();
      timer.reset(const Duration(seconds: 10));
      expect(timer.elapsedTime, Duration.zero);
      expect(timer.remaining, const Duration(seconds: 10));
    });

    test('elapsed time increases while running', () async {
      final timer = ActivityTimeTracker(const Duration(seconds: 5), () {});
      timer.start();
      await Future.delayed(const Duration(seconds: 1));
      expect(timer.elapsedTime, greaterThan(Duration.zero));
      expect(timer.elapsedTime, const Duration(seconds: 1));
    });

    test('remaining time decreases while running', () async {
      final timer = ActivityTimeTracker(const Duration(seconds: 5), () {});
      timer.start();
      await Future.delayed(const Duration(seconds: 1));
      expect(timer.remaining, lessThan(const Duration(seconds: 5)));
      expect(timer.remaining, const Duration(seconds: 4));
    });

    test('timer calls onTimeUp when time is up', () async {
      bool called = false;
      final timer = ActivityTimeTracker(const Duration(seconds: 1), () {
        called = true;
      });
      timer.start();
      await Future.delayed(const Duration(seconds: 1));
      expect(called, isTrue);
    });

    test('elapsed time does not increase after stopping', () async {
      final timer = ActivityTimeTracker(const Duration(seconds: 1), () {});
      timer.start();
      await Future.delayed(const Duration(milliseconds: 100));
      final elapsedTime = timer.elapsedTime;
      timer.pause();
      await Future.delayed(const Duration(milliseconds: 100));
      expect(timer.elapsedTime, equals(elapsedTime));
    });

    test(
        "start timer when it is already running and it"
        " doesn't throw any error or exception", () async {
      final timer = ActivityTimeTracker(
        const Duration(seconds: 10),
        () {},
      );
      timer.start();
      await Future.delayed(const Duration(seconds: 1));
      final startTime = timer.elapsedTime;
      timer.start();
      expect(timer.elapsedTime, startTime);
    });

    test(
        'reset timer when it is not running does not throw'
        'any error or exception', () {
      const totalTime = Duration(seconds: 10);
      final timer = ActivityTimeTracker(
        totalTime,
        () {},
      );
      timer.reset();
      expect(timer.isRunning, isFalse);
      expect(timer.elapsedTime, Duration.zero);
      expect(timer.remaining, totalTime);
    });
  });
}
