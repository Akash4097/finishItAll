// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_app_database.dart';

// ignore_for_file: type=lint
class $TaskDriftEntitryTable extends TaskDriftEntitry
    with TableInfo<$TaskDriftEntitryTable, TaskDriftEntitryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskDriftEntitryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task_drift_entitry';
  @override
  VerificationContext validateIntegrity(
      Insertable<TaskDriftEntitryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskDriftEntitryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskDriftEntitryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
    );
  }

  @override
  $TaskDriftEntitryTable createAlias(String alias) {
    return $TaskDriftEntitryTable(attachedDatabase, alias);
  }
}

class TaskDriftEntitryData extends DataClass
    implements Insertable<TaskDriftEntitryData> {
  final String id;
  final String title;
  const TaskDriftEntitryData({required this.id, required this.title});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    return map;
  }

  TaskDriftEntitryCompanion toCompanion(bool nullToAbsent) {
    return TaskDriftEntitryCompanion(
      id: Value(id),
      title: Value(title),
    );
  }

  factory TaskDriftEntitryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskDriftEntitryData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
    };
  }

  TaskDriftEntitryData copyWith({String? id, String? title}) =>
      TaskDriftEntitryData(
        id: id ?? this.id,
        title: title ?? this.title,
      );
  @override
  String toString() {
    return (StringBuffer('TaskDriftEntitryData(')
          ..write('id: $id, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskDriftEntitryData &&
          other.id == this.id &&
          other.title == this.title);
}

class TaskDriftEntitryCompanion extends UpdateCompanion<TaskDriftEntitryData> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> rowid;
  const TaskDriftEntitryCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaskDriftEntitryCompanion.insert({
    required String id,
    required String title,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title);
  static Insertable<TaskDriftEntitryData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaskDriftEntitryCompanion copyWith(
      {Value<String>? id, Value<String>? title, Value<int>? rowid}) {
    return TaskDriftEntitryCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskDriftEntitryCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$DriftAppDatabase extends GeneratedDatabase {
  _$DriftAppDatabase(QueryExecutor e) : super(e);
  _$DriftAppDatabaseManager get managers => _$DriftAppDatabaseManager(this);
  late final $TaskDriftEntitryTable taskDriftEntitry =
      $TaskDriftEntitryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [taskDriftEntitry];
}

typedef $$TaskDriftEntitryTableInsertCompanionBuilder
    = TaskDriftEntitryCompanion Function({
  required String id,
  required String title,
  Value<int> rowid,
});
typedef $$TaskDriftEntitryTableUpdateCompanionBuilder
    = TaskDriftEntitryCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<int> rowid,
});

class $$TaskDriftEntitryTableTableManager extends RootTableManager<
    _$DriftAppDatabase,
    $TaskDriftEntitryTable,
    TaskDriftEntitryData,
    $$TaskDriftEntitryTableFilterComposer,
    $$TaskDriftEntitryTableOrderingComposer,
    $$TaskDriftEntitryTableProcessedTableManager,
    $$TaskDriftEntitryTableInsertCompanionBuilder,
    $$TaskDriftEntitryTableUpdateCompanionBuilder> {
  $$TaskDriftEntitryTableTableManager(
      _$DriftAppDatabase db, $TaskDriftEntitryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TaskDriftEntitryTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TaskDriftEntitryTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$TaskDriftEntitryTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TaskDriftEntitryCompanion(
            id: id,
            title: title,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required String title,
            Value<int> rowid = const Value.absent(),
          }) =>
              TaskDriftEntitryCompanion.insert(
            id: id,
            title: title,
            rowid: rowid,
          ),
        ));
}

class $$TaskDriftEntitryTableProcessedTableManager
    extends ProcessedTableManager<
        _$DriftAppDatabase,
        $TaskDriftEntitryTable,
        TaskDriftEntitryData,
        $$TaskDriftEntitryTableFilterComposer,
        $$TaskDriftEntitryTableOrderingComposer,
        $$TaskDriftEntitryTableProcessedTableManager,
        $$TaskDriftEntitryTableInsertCompanionBuilder,
        $$TaskDriftEntitryTableUpdateCompanionBuilder> {
  $$TaskDriftEntitryTableProcessedTableManager(super.$state);
}

class $$TaskDriftEntitryTableFilterComposer
    extends FilterComposer<_$DriftAppDatabase, $TaskDriftEntitryTable> {
  $$TaskDriftEntitryTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TaskDriftEntitryTableOrderingComposer
    extends OrderingComposer<_$DriftAppDatabase, $TaskDriftEntitryTable> {
  $$TaskDriftEntitryTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$DriftAppDatabaseManager {
  final _$DriftAppDatabase _db;
  _$DriftAppDatabaseManager(this._db);
  $$TaskDriftEntitryTableTableManager get taskDriftEntitry =>
      $$TaskDriftEntitryTableTableManager(_db, _db.taskDriftEntitry);
}
