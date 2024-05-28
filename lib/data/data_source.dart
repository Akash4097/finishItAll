import '../data_models/task.dart';

abstract interface class DataSource {
  Future<bool> addTask(Task task);
  Future<bool> deleteTask(String taskId);
  Future<Task?> getTask(String taskId);
  Future<List<Task>> geTasks();
  Future<Task> updateTask(Task updatedTask);
}
