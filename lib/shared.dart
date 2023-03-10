import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static dynamic instance = 0;

  late SharedPreferences preferences;

  static Future<Shared> get() async {
    if (instance is! Shared) {
      var preferences = await SharedPreferences.getInstance();
      Shared.instance = Shared(preferences);
    }
    return Shared.instance;
  }

  Shared(this.preferences);
}

class ChargingIcons {
  static const charging = Icons.bolt;
  static const pluggedin = Icons.electrical_services;
  static const notpluggedin = Icons.power_off;
}
