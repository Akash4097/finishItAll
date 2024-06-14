import '../data_models/activity.dart';
import 'activity_timmer.dart';

class ActivityManager {
  final Map<String, Activity> _activities = {};
  final Map<String, ActivityTimeTracker> _timers = {};

  // void addActivity(
  //   String id,
  //   String name,
  //   Duration duration,
  //   Function onTimeUp,
  // ) {
  //   if (_activities.containsKey(id)) {
  //     throw ArgumentError("Activity with the given ID already exists");
  //   }
  //   _activities[id] = Activity(id: id, name: name, duration: duration);
  //   _timers[id] = ActivityTimer(duration, onTimeUp);
  // }

  void startActivityTimer(String id) {
    final timer = _getTimerById(id);
    timer.start();
  }

  void pauseActivityTimer(String id) {
    final timer = _getTimerById(id);
    timer.pause();
  }

  void resumeActivityTimer(String id) {
    final timer = _getTimerById(id);
    timer.resume();
  }

  void closeActivityTimer(String id) {
    final timer = _getTimerById(id);
    timer.close();
  }

  Duration getElapsed(String id) {
    final timer = _getTimerById(id);
    return timer.elapsed;
  }

  Duration getRemaining(String id) {
    final timer = _getTimerById(id);
    return timer.remaining;
  }

  Activity _getActivityById(String id) {
    final activity = _activities[id];
    if (activity == null) {
      throw ArgumentError("No activity found with the given ID");
    }
    return activity;
  }

  ActivityTimeTracker _getTimerById(String id) {
    final timer = _timers[id];
    if (timer == null) {
      throw ArgumentError("No timer found for the given activity ID");
    }
    return timer;
  }

  List<Activity> listActivities() {
    return _activities.values.toList();
  }
}
