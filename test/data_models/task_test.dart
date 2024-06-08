import 'package:finish_it_all/data_models/activity.dart';
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

    test('toJson method with only required fields', () {
      final task = Task(
        dueDate: DateTime(2023, 12, 31),
        id: '1',
        title: 'Test Task',
        createdAt: DateTime(2023, 1, 1),
      );

      final json = task.toJson();

      expect(json['id'], '1');
      expect(json['dueDate'], DateTime(2023, 12, 31).millisecondsSinceEpoch);
      expect(json['createdAt'], DateTime(2023, 1, 1).millisecondsSinceEpoch);
      expect(json['title'], 'Test Task');
      expect(json['description'], isNull);
      expect(json['updatedAt'], isNull);
      expect(json['status'], 'idle');
      expect(json['totalTime'], 0.0);
      expect(json['tags'], isNull);
    });

    test('fromJson method with only required fields', () {
      final Map<String, dynamic> json = {
        'id': '1',
        'dueDate': DateTime(2023, 12, 31).millisecondsSinceEpoch,
        'createdAt': DateTime(2023, 1, 1).millisecondsSinceEpoch,
        'title': 'Test Task',
      };

      final Task task = Task.fromJson(json);

      expect(task.id, '1');
      expect(task.dueDate, DateTime(2023, 12, 31));
      expect(task.createdAt, DateTime(2023, 1, 1));
      expect(task.title, 'Test Task');
      expect(task.totalTime, 0.0);
      expect(task.tags, isNull);
      expect(task.status, Status.idle);
    });
  });
}
