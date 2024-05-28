import 'package:drift/native.dart';
import 'package:finish_it_all/data/local/drift/drift_app_database.dart';
import 'package:finish_it_all/data/local/drift/drift_local_data_source.dart';
import 'package:finish_it_all/data_models/task.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("DriftLocalDataSource Tests", () {
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
  });
}
