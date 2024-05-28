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
    } on Exception catch (e) {
      throw Exception(
        "Failed to add task to the database. Task ID: ${task.id}, Title: ${task.title}. Error: $e",
      );
    }
  }

  @override
  Future<bool> deleteTask(String taskId) {
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> geTasks() {
    throw UnimplementedError();
  }

  @override
  Future<Task> getTask(String taskId) {
    throw UnimplementedError();
  }

  @override
  Future<Task> updateTask(Task updatedTask) {
    throw UnimplementedError();
  }
}
