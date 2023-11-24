import 'package:realm/realm.dart';
import 'package:realm_test/todo.dart';

App? _app;
late Realm _realm;

App? get app => _app;
Realm get realmSync => _realm;

Future<void> initRealmSync() async {
  _app = App(AppConfiguration("application-0-resug"));
  User user = _app?.currentUser ?? await _app!.logIn(Credentials.anonymous());
  _realm = Realm(Configuration.flexibleSync(user, [Todo.schema]));
}
