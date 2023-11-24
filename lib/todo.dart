import 'package:realm/realm.dart';
part 'todo.g.dart';

@RealmModel()
class _Todo {
  @PrimaryKey()
  @MapTo("_id")
  late String id;
  late String title;
  late bool isDone;
  late int priority;
}
