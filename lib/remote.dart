import 'dart:convert';

import 'package:dartcarwings/dartcarwings.dart';
import 'package:leafwatch/accounts.dart';

class Leaf extends Account {
  CarwingsSession session = CarwingsSession(debug: true);

  Leaf._({required super.id, required super.username, required super.password});

  static Future<Leaf> login(String id, String username, String password) async {
    Leaf leaf = Leaf._(id: id, username: username, password: password);
    await leaf.session.login(username: username, password: password);
    if (leaf.session.loggedIn = true) {
      return leaf;
    }
    throw 'Login Error';
  }

  static Leaf parse(String string) {
    return fromJson(json.decode(string));
  }

  static Leaf fromJson(dynamic data) {
    return Leaf._(
        id: data['id'], username: data['username'], password: data['password']);
  }
}
