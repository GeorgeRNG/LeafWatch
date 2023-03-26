import 'dart:convert';

import 'package:dartcarwings/dartcarwings.dart';
import 'package:leafwatch/accounts.dart';

class Leaf extends Account {
  CarwingsSession session = CarwingsSession(debug: true);

  Leaf._({required super.id, required super.username, required super.password});

  login() async {
    if (!session.loggedIn) {
      await session.login(username: username, password: password);
      if (!session.loggedIn) {
        throw 'Login Error';
      }
    }
  }

  @override
  Future<double> getCharge() async {
    await login();
    var battery = await session.vehicle.requestBatteryStatus();
    if (battery?.batteryLevel != null) {
      return (battery?.batteryLevel as double) /
          (battery?.batteryLevelCapacity as double);
    }
    throw "Couldn't get charge";
  }

  static Future<Leaf> createWithLogin(
      String id, String username, String password) async {
    Leaf leaf = Leaf._(id: id, username: username, password: password);
    await leaf.login();
    return leaf;
  }

  static Leaf parse(String string) {
    return fromJson(json.decode(string));
  }

  static Leaf fromJson(dynamic data) {
    Leaf leaf = Leaf._(
        id: data['id'], username: data['username'], password: data['password']);
    leaf.login();
    return leaf;
  }
}
