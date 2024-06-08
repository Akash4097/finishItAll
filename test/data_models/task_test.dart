import 'package:flutter_test/flutter_test.dart';
import 'package:finish_it_all/data_models/task.dart';
import 'package:finish_it_all/data_models/tag.dart';

void main() {
  group('Task', () {
    late Task task;
    final tags = [
      Tag(id: "101", tagName: 'Work'),
      Tag(id: "102", tagName: 'Urgent'),
    ];
    setUp(() {
      task = Task(
        id: '1',
        title: 'Test Task',
        createdAt: DateTime.now(),
        dueDate: DateTime.now().add(
          const Duration(days: 1),
        ),
        totalTime: 60.0,
        tags: tags,
      );
    });

    test('toJson', () {
      final json = task.toJson();
      expect(json['id'], task.id);
      expect(json['title'], task.title);
      expect(json['createdAt'], task.createdAt.millisecondsSinceEpoch);
      expect(json['dueDate'], task.dueDate.millisecondsSinceEpoch);
      expect(json['totalTime'], task.totalTime);
      expect(json['tags'], isNotNull);
      expect(json['tags']!.length, task.tags!.length);
    });

    test('fromJson', () {
      final json = task.toJson();
      final taskFromJson = Task.fromJson(json);
      expect(taskFromJson.id, task.id);
      expect(taskFromJson.title, task.title);
      expect(taskFromJson.createdAt.millisecondsSinceEpoch,
          task.createdAt.millisecondsSinceEpoch);
      expect(taskFromJson.dueDate.millisecondsSinceEpoch,
          task.dueDate.millisecondsSinceEpoch);
      expect(taskFromJson.totalTime, task.totalTime);
      expect(taskFromJson.tags!.length, task.tags!.length);
    });

    test('copyWith', () {
      const newTitle = 'Updated Task';
      final updatedTask = task.copyWith(title: newTitle);
      expect(updatedTask.id, task.id);
      expect(updatedTask.title, newTitle);
      expect(updatedTask.createdAt, task.createdAt);
      expect(updatedTask.dueDate, task.dueDate);
      expect(updatedTask.totalTime, task.totalTime);
      expect(updatedTask.tags!.length, task.tags!.length);
    });

    test('equality operator', () {
      final sameTask = Task(
        id: '1',
        title: 'Test Task',
        createdAt: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 1)),
        totalTime: 60.0,
        tags: tags,
      );
      final differentTask = Task(
        id: '2',
        title: 'Another Task',
        createdAt: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 2)),
        totalTime: 90.0,
        tags: [
          Tag(id: "103", tagName: 'Personal'),
        ],
      );

      expect(task == sameTask, true);
      expect(task == differentTask, false);
    });
  });
}
