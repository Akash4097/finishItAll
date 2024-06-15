import 'package:drift/native.dart';
import 'package:finish_it_all/data/local/drift/drift_app_database.dart';
import 'package:finish_it_all/data/local/drift/drift_local_data_source.dart';
import 'package:finish_it_all/data_models/task.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("DriftLocalDataSource addActivity() Tests", () {
    late DriftLocalDataSource local;
    late DriftAppDatabase database;
    setUp(() async {
      database = DriftAppDatabase(db: NativeDatabase.memory());

      local = DriftLocalDataSource(driftAppDatabase: database);
    });

    tearDown(() async {
      await database.close();
    });

    test('addActivity returns true on successfully added new task as Activity',
        () async {
      //Arrange
      final task = Task(
        id: '1',
        title: 'Test Task',
        createdAt: DateTime.now(),
        dueDate: DateTime.now().add(
          const Duration(days: 1),
        ),
      );

      // Act
      final result = await local.addActivity(task);

      // Assert
      expect(result, true);
      final insertedTask =
          await database.select(database.taskDriftEntitry).getSingle();
      expect(insertedTask.title, task.title);
      expect(insertedTask.id, task.id);
    });

    test('addActivity rethrow Exception when inserting duplicate task ID',
        () async {
      //Arrange
      final task = Task(
        id: '1',
        title: 'Test Task',
        createdAt: DateTime.now(),
        dueDate: DateTime.now().add(
          const Duration(days: 1),
        ),
      );
      final task2 = Task(
        id: '1',
        title: 'Test Task2',
        createdAt: DateTime.now(),
        dueDate: DateTime.now().add(
          const Duration(days: 2),
        ),
      );
      await local.addActivity(task);

      // Act & Assert
      expect(() async => await local.addActivity(task2),
          throwsA(isA<SqliteException>()));
    });
  });

  group("DriftLocalDataSource deleteActivity() Tests", () {
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
        'deleteActivity: delete a task(Activity) and return true on successfully deleted'
        'a task of specific id from the database', () async {
      // Arrange
      final task = Task(
        id: '1',
        title: 'Test Task',
        createdAt: DateTime.now(),
        dueDate: DateTime.now().add(
          const Duration(days: 1),
        ),
      );
      await local.addActivity(task);

      // Act
      final result = await local.deleteActivity(task.id);

      // Assert
      expect(result, true);
      final fetchedTask =
          await database.select(database.taskDriftEntitry).getSingleOrNull();
      expect(fetchedTask, isNull);
    });

    test('deleteActivity returns false when task(Activity) does not exist',
        () async {
      // Act
      final result = await local.deleteActivity('non_existing_id');

      // Assert
      expect(result, false);
    });
  });

  group("DriftLocalDataSource getActivity(taskId) Tests", () {
    late DriftLocalDataSource local;
    late DriftAppDatabase database;
    setUp(() async {
      database = DriftAppDatabase(db: NativeDatabase.memory());

      local = DriftLocalDataSource(driftAppDatabase: database);
    });

    tearDown(() async {
      await database.close();
    });

    test('getActivity successfully fetches an existing task(Activity)',
        () async {
      // Arrange
      final task = Task(
        id: '1',
        title: 'Test Task',
        createdAt: DateTime.now(),
        dueDate: DateTime.now().add(
          const Duration(days: 1),
        ),
      );
      await local.addActivity(task);

      // Act
      final result = await local.getActivity(task.id);

      // Assert
      expect(result, isNotNull);
      expect(result?.id, task.id);
      expect(result?.title, task.title);
    });

    test('getActivity returns null when task(Activity) does not exist',
        () async {
      // Act
      final result = await local.getActivity("9");

      // Assert
      expect(result, isNull);
    });
  });

  group("DriftLocalDataSource getActivities() Tests", () {
    late DriftLocalDataSource local;
    late DriftAppDatabase database;
    setUp(() async {
      database = DriftAppDatabase(db: NativeDatabase.memory());

      local = DriftLocalDataSource(driftAppDatabase: database);
    });

    tearDown(() async {
      await database.close();
    });

    test('getActivities return empty list when no task has found', () async {
      // Act
      final result = await local.getActivities();

      // Assert
      expect(result.length, 0);
    });

    test('getActivities successfully fetches all tasks', () async {
      // Arrange
      final taskDataList = [
        Task(
          id: '1',
          title: 'Test Task',
          createdAt: DateTime.now(),
          dueDate: DateTime.now().add(
            const Duration(days: 1),
          ),
        ),
        Task(
          id: '2',
          title: 'Test Task2',
          createdAt: DateTime.now(),
          dueDate: DateTime.now().add(
            const Duration(days: 2),
          ),
        )
      ];

      local.addActivity(taskDataList[0]);
      local.addActivity(taskDataList[1]);

      // Act
      final result = await local.getActivities();

      // Assert
      expect(result.length, 2);
      expect(result[0].id, '1');
      expect(result[0].title, 'Test Task');
      expect(result[1].id, '2');
      expect(result[1].title, 'Test Task2');
    });
  });

  group("DriftLocalDataSource updateActivity(task) Tests", () {
    late DriftLocalDataSource local;
    late DriftAppDatabase database;
    setUp(() async {
      database = DriftAppDatabase(db: NativeDatabase.memory());

      local = DriftLocalDataSource(driftAppDatabase: database);
    });

    tearDown(() async {
      await database.close();
    });

    test('updateActivity successfully updates an existing task(Activity)',
        () async {
      // Arrange
      const taskId = '1';
      final taskData = Task(
        id: taskId,
        title: 'Test Task',
        createdAt: DateTime.now(),
        dueDate: DateTime.now().add(
          const Duration(days: 1),
        ),
      );
      await local.addActivity(taskData);

      final updatedTask = Task(
        id: taskId,
        title: 'Test Task updatedTask',
        createdAt: DateTime.now(),
        dueDate: DateTime.now().add(
          const Duration(days: 2),
        ),
      );

      // Act
      final result = await local.updateActivity(updatedTask);

      // Assert
      expect(result, true);
      final updatedTaskData = await local.getActivity(taskId) as Task;
      expect(updatedTaskData.title, updatedTask.title);
      expect(updatedTaskData.dueDate.isAfter(taskData.dueDate), true);
    });

    test('updateActivity returns false when task(Activity) does not exist',
        () async {
      // Arrange
      const taskId = '9';
      final updatedTask = Task(
        id: taskId,
        title: 'Test Task updatedTask',
        createdAt: DateTime.now(),
        dueDate: DateTime.now().add(
          const Duration(days: 2),
        ),
      );

      // Act
      final result = await local.updateActivity(updatedTask);

      // Assert
      expect(result, false);
    });
  });
}
