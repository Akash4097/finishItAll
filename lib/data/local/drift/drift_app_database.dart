import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'drift_app_database.g.dart';

class TaskDriftEntitry extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DriftDatabase(tables: [TaskDriftEntitry])
class DriftAppDatabase extends _$DriftAppDatabase {
  DriftAppDatabase({NativeDatabase? db}) : super(db ?? _openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    if (kReleaseMode) {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file =
          File(path.join(dbFolder.path, 'finishItAll/data/r_db.sqlite'));
      return NativeDatabase.createInBackground(file);
    }
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'finishIt/debugData/db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
