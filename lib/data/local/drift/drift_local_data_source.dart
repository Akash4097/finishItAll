import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:finish_it_all/common/app_logger/app_logger.dart';

import '../../../data_models/task.dart';
import '../../data_source.dart';
import 'drift_app_database.dart';

class DriftLocalDataSource implements DataSource {
  final DriftAppDatabase _db;

  DriftLocalDataSource({required DriftAppDatabase driftAppDatabase})
      : _db = driftAppDatabase;
  final _logger = AppLogger.init(DriftLocalDataSource);

  @override
  Future<bool> addTask(Task task) async {
    try {
      await _db.into(_db.taskDriftEntitry).insert(
            TaskDriftEntitryCompanion.insert(
              title: task.title,
              id: task.id,
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

  @override
  Future<bool> deleteTask(String taskId) async {
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
  Future<List<Task>> geTasks() async {
    try {
      // Fetch all tasks from the database
      final taskDataList = await _db.select(_db.taskDriftEntitry).get();

      // Convert the list of database entities to a list of Task models
      final tasks = taskDataList.map((taskData) {
        return Task(id: taskData.id, title: taskData.title);
      }).toList();
      _logger.info("getTask(): Successfully fetched ${tasks.length} tasks.");
      return tasks;
    } on Exception catch (e) {
      throw Exception(
        "getTask(): An unexpected error occurred while fetching tasks. Error: $e",
      );
    }
  }

  @override
  Future<Task?> getTask(String taskId) async {
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
      final task = Task(id: taskData.id, title: taskData.title);
      _logger.info("getTask(): Task with ID $taskId successfully fetched.");
      return task;
    } on Exception catch (e) {
      throw Exception(
        "Exception occurred while fetching task. Task ID: $taskId. Error: $e",
      );
    }
  }

  @override
  Future<bool> updateTask(Task updatedTask) async {
    try {
      // Check if the task exists
      final taskExists = await (_db.select(_db.taskDriftEntitry)
            ..where((tbl) => tbl.id.equals(updatedTask.id)))
          .getSingleOrNull();

      if (taskExists == null) {
        _logger.warning(
            "updateTask(): Task with ID ${updatedTask.id} does not exist.");
        return false;
      }

      // Update the task
      await (_db.update(_db.taskDriftEntitry)
            ..where((tbl) => tbl.id.equals(updatedTask.id)))
          .write(
        TaskDriftEntitryCompanion(
          title: Value(updatedTask.title),
        ),
      );
      _logger.info(
          "updateTask(): Task with ID ${updatedTask.id} successfully updated.");
      return true;
    } on Exception catch (e) {
      throw Exception(
          "Exception occurred while updating task. Task ID: ${updatedTask.id}. Error: $e");
    }
  }
}
