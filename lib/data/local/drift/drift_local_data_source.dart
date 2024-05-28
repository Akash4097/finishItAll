import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import '../../../data_models/task.dart';
import '../../data_source.dart';
import 'drift_app_database.dart';

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
    try {
      // Fetch all tasks from the database
      final taskDataList = await _db.select(_db.taskDriftEntitry).get();

      // Convert the list of database entities to a list of Task models
      final tasks = taskDataList.map((taskData) {
        return Task(id: taskData.id, title: taskData.title);
      }).toList();
      return tasks;
    } on Exception catch (e) {
      throw Exception(
          "An unexpected error occurred while fetching tasks. Error: $e");
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
  Future<bool> updateTask(Task updatedTask) async {
    try {
      // Check if the task exists
      final taskExists = await (_db.select(_db.taskDriftEntitry)
            ..where((tbl) => tbl.id.equals(updatedTask.id)))
          .getSingleOrNull();

      if (taskExists == null) {
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
      return true;
    } on Exception catch (e) {
      throw Exception(
          "Database error occurred while updating task. Task ID: ${updatedTask.id}. Error: $e");
    }
  }
}
