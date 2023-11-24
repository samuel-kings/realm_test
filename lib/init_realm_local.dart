import 'package:realm/realm.dart';
import 'package:realm_test/todo.dart';

late Realm _realm;

Realm get realmLocal => _realm;

void initRealmLocal() {
  _realm = Realm(Configuration.local([Todo.schema]));
}
