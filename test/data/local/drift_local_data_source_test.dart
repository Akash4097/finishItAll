import 'package:drift/native.dart';
import 'package:finish_it_all/data/local/drift/drift_app_database.dart';
import 'package:finish_it_all/data/local/drift/drift_local_data_source.dart';
import 'package:finish_it_all/data_models/task.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("DriftLocalDataSource addTask() Tests", () {
    late DriftLocalDataSource local;
    late DriftAppDatabase database;
    setUp(() async {
      database = DriftAppDatabase(db: NativeDatabase.memory());

      local = DriftLocalDataSource(driftAppDatabase: database);
    });

    tearDown(() async {
      await database.close();
    });

    test('addTask returns true on successfully added new task', () async {
      //Arrange
      final task = Task(id: '1', title: 'Test Task');

      // Act
      final result = await local.addTask(task);

      // Assert
      expect(result, true);
      final insertedTask =
          await database.select(database.taskDriftEntitry).getSingle();
      expect(insertedTask.title, task.title);
      expect(insertedTask.id, task.id);
    });

    test('addTask rethrow Exception when inserting duplicate task ID',
        () async {
      //Arrange
      final task = Task(id: '1', title: 'Test Task 1');
      final task2 = Task(id: '1', title: 'Test Task 2');
      await local.addTask(task);

      // Act & Assert
      expect(() async => await local.addTask(task2),
          throwsA(isA<SqliteException>()));
    });
  });

  group("DriftLocalDataSource deleteTask() Tests", () {
    late DriftLocalDataSource local;
    late DriftAppDatabase database;
    setUp(() async {
      database = DriftAppDatabase(db: NativeDatabase.memory());

      local = DriftLocalDataSource(driftAppDatabase: database);
    });

    tearDown(() async {
      await database.close();
    });

    test(
        'deleteTask: delete a task and return true on successfully deleted'
        'a task of specific id from the database', () async {
// Arrange
      final task = Task(id: '1', title: 'Test Task');
      await local.addTask(task);

      // Act
      final result = await local.deleteTask(task.id);

      // Assert
      expect(result, true);
      final fetchedTask =
          await database.select(database.taskDriftEntitry).getSingleOrNull();
      expect(fetchedTask, isNull);
    });

    test('deleteTask returns false when task does not exist', () async {
      // Act
      final result = await local.deleteTask('non_existing_id');

      // Assert
      expect(result, false);
    });
  });
}
