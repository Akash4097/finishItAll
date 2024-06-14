import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import '../../../common/app_logger/app_logger.dart';

import '../../../data_models/activity.dart';
import '../../../data_models/task.dart';
import '../../data_source.dart';
import 'drift_app_database.dart';

class DriftLocalDataSource implements DataSource {
  final DriftAppDatabase _db;

  DriftLocalDataSource({required DriftAppDatabase driftAppDatabase})
      : _db = driftAppDatabase;
  final _logger = AppLogger.init(DriftLocalDataSource);

  @override
  Future<bool> addActivity(Activity activity) async {
    if (activity is Task) {
      final task = activity;
      if (!task.dueDate.isAfter(task.createdAt)) {
        _logger.info(
            "addActivity(): can't add new task having dueDate before createdAt date");
        throw Exception('Task(Activity) dueDate must be after createdAt date');
      }
      try {
        await _db.into(_db.taskDriftEntitry).insert(
              TaskDriftEntitryCompanion.insert(
                title: task.title,
                id: task.id,
                dueDate: task.dueDate,
                createdAt: task.createdAt,
                updatedAt: Value(task.updatedAt),
                description: Value(task.description),
                status: Value(task.status.name),
                totalTime: Value(task.totalTime),
              ),
            );
        _logger.info("addTask(): successfully added new task to the database.");
        return true;
      } on SqliteException catch (e) {
        _logger.severe(
          "SQliteException error occurred while adding task. Task ID: ${task.id},"
          " Title: ${task.title} . Error: $e",
        );
        rethrow;
      } on Exception catch (e) {
        _logger.severe(
          "Failed to add task to the database. "
          "Task ID: ${task.id}, Title: ${task.title}. Error: $e",
        );
        throw Exception(
          "Failed to add task to the database. "
          "Task ID: ${task.id}, Title: ${task.title}. Error: $e",
        );
      }
    }
    _logger.error("Given Activity is not a Task");
    throw Exception("Given Activity is not a Task");
  }

  @override
  Future<bool> deleteActivity(String taskId) async {
    try {
      // Check if the task exists
      final taskExists = await (_db.select(_db.taskDriftEntitry)
            ..where((tbl) => tbl.id.equals(taskId)))
          .getSingleOrNull();

      if (taskExists == null) {
        _logger.warning("deleteTask(): Task with ID $taskId does not exist.");
        return false;
      }

      // Delete the task
      await (_db.delete(_db.taskDriftEntitry)
            ..where((tbl) => tbl.id.equals(taskId)))
          .go();

      _logger.info("Task with ID $taskId successfully deleted.");
      return true;
    } on Exception catch (e) {
      _logger.severe(
        "Failed to delete task from the database. "
        "Task ID: $taskId, Error: $e",
      );
      rethrow;
    }
  }

  @override
  Future<List<Activity>> getActivities() async {
    try {
      // Fetch all tasks from the database
      final taskDataList = await _db.select(_db.taskDriftEntitry).get();

      // Convert the list of database entities to a list of Task models
      final tasks = taskDataList.map((taskData) {
        return Task(
          id: taskData.id,
          title: taskData.title,
          dueDate: taskData.dueDate,
          createdAt: taskData.createdAt,
          description: taskData.description,
          status: Status.values.byName(taskData.status),
          totalTime: taskData.totalTime,
          updatedAt: taskData.updatedAt,
        );
      }).toList();
      _logger
          .info("getActivities(): Successfully fetched ${tasks.length} tasks.");
      return tasks;
    } on Exception catch (e) {
      throw Exception(
        "getActivities(): An unexpected error occurred while fetching tasks. Error: $e",
      );
    }
  }

  @override
  Future<Activity?> getActivity(String taskId) async {
    try {
      // Fetch the task from the database
      final taskData = await (_db.select(_db.taskDriftEntitry)
            ..where((tbl) => tbl.id.equals(taskId)))
          .getSingleOrNull();

      if (taskData == null) {
        _logger.warning("getTask(): Task with ID $taskId does not exist.");
        return null;
      }

      // Convert the database entity to a Task model
      final task = Task(
        id: taskData.id,
        title: taskData.title,
        dueDate: taskData.dueDate,
        createdAt: taskData.createdAt,
        description: taskData.description,
        status: Status.values.byName(taskData.status),
        totalTime: taskData.totalTime,
        updatedAt: taskData.updatedAt,
      );
      _logger.info("getActivity(): Task with ID $taskId successfully fetched.");
      return task;
    } on Exception catch (e) {
      throw Exception(
        "Exception occurred while fetching task. Task ID: $taskId. Error: $e",
      );
    }
  }

  @override
  Future<bool> updateActivity(Activity updatedActivity) async {
    try {
      // Check if the task exists
      final taskExists = await (_db.select(_db.taskDriftEntitry)
            ..where((tbl) => tbl.id.equals(updatedActivity.id)))
          .getSingleOrNull();

      if (taskExists == null) {
        _logger.warning(
            "updateActivity(): Task with ID ${updatedActivity.id} does not exist.");
        return false;
      }
      final updatedTask = updatedActivity as Task;
      // Update the task
      await (_db.update(_db.taskDriftEntitry)
            ..where((tbl) => tbl.id.equals(updatedActivity.id)))
          .write(
        TaskDriftEntitryCompanion(
          id: Value(updatedTask.id),
          title: Value(updatedTask.title),
          description: Value(updatedTask.description),
          updatedAt: Value(updatedTask.updatedAt),
          createdAt: Value(updatedTask.createdAt),
          status: Value(updatedTask.status.name),
          totalTime: Value(updatedTask.totalTime),
          dueDate: Value(updatedTask.dueDate),
        ),
      );
      _logger.info(
          "updateTask(): Task with ID ${updatedActivity.id} successfully updated.");
      return true;
    } on Exception catch (e) {
      throw Exception(
          "Exception occurred while updating task. Task ID: ${updatedActivity.id}. Error: $e");
    }
  }
}
