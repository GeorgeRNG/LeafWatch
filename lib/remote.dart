import 'package:dartcarwings/dartcarwings.dart';

class Leaf {
  CarwingsSession session = CarwingsSession(debug: true);

  Leaf._();

  static Future<Leaf> login(String username, String password) async {
    Leaf leaf = Leaf._();
    await leaf.session.login(username: username, password: password);
    if (leaf.session.loggedIn = true) {
      return leaf;
    }
    throw 'Login Error';
  }
}
