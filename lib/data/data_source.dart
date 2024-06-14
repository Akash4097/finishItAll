import '../data_models/activity.dart';

abstract interface class DataSource {
  Future<bool> addActivity(Activity activity);
  Future<bool> deleteActivity(String activityId);
  Future<Activity?> getActivity(String taskId);
  Future<List<Activity>> getActivities();
  Future<bool> updateActivity(Activity updatedActivity);
}
