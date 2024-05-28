import 'package:drift/native.dart';

import 'drift_app_database.dart';

import '../../data_source.dart';
import '../../../data_models/task.dart';

class DriftLocalDataSource implements DataSource {
  final DriftAppDatabase _db;

  DriftLocalDataSource({required DriftAppDatabase driftAppDatabase})
      : _db = driftAppDatabase;

  @override
  Future<bool> addTask(Task task) async {
    try {
      await _db.into(_db.taskDriftEntitry).insert(
            TaskDriftEntitryCompanion.insert(
              title: task.title,
              id: task.id,
            ),
          );
      return true;
    } on SqliteException catch (e) {
      rethrow;
    } on Exception catch (e) {
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
        return false;
      }

      // Delete the task
      await (_db.delete(_db.taskDriftEntitry)
            ..where((tbl) => tbl.id.equals(taskId)))
          .go();
      return true;
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Task>> geTasks() async {
    return <Task>[];
  }

  @override
  Future<Task?> getTask(String taskId) async {
    try {
      // Fetch the task from the database
      final taskData = await (_db.select(_db.taskDriftEntitry)
            ..where((tbl) => tbl.id.equals(taskId)))
          .getSingleOrNull();

      if (taskData == null) {
        return null;
      }

      // Convert the database entity to a Task model
      final task = Task(id: taskData.id, title: taskData.title);
      return task;
    } on Exception catch (e) {
      throw Exception(
          "Database error occurred while fetching task. Task ID: $taskId. Error: $e");
    }
  }

  @override
  Future<Task> updateTask(Task updatedTask) {
    throw UnimplementedError();
  }
}
