// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Todo extends _Todo with RealmEntity, RealmObjectBase, RealmObject {
  Todo(
    String id,
    String title,
    bool isDone,
    int priority,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'isDone', isDone);
    RealmObjectBase.set(this, 'priority', priority);
  }

  Todo._();

  @override
  String get id => RealmObjectBase.get<String>(this, '_id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  bool get isDone => RealmObjectBase.get<bool>(this, 'isDone') as bool;
  @override
  set isDone(bool value) => RealmObjectBase.set(this, 'isDone', value);

  @override
  int get priority => RealmObjectBase.get<int>(this, 'priority') as int;
  @override
  set priority(int value) => RealmObjectBase.set(this, 'priority', value);

  @override
  Stream<RealmObjectChanges<Todo>> get changes =>
      RealmObjectBase.getChanges<Todo>(this);

  @override
  Todo freeze() => RealmObjectBase.freezeObject<Todo>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Todo._);
    return const SchemaObject(ObjectType.realmObject, Todo, 'Todo', [
      SchemaProperty('id', RealmPropertyType.string,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('isDone', RealmPropertyType.bool),
      SchemaProperty('priority', RealmPropertyType.int),
    ]);
  }
}
