import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:leafwatch/remote.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

const uuid = Uuid(options: {'grng': UuidUtil.cryptoRNG});

class Accounts {
  static Accounts instance = Accounts();
  FlutterSecureStorage storage = const FlutterSecureStorage();

  bool isReady = false;
  Map<AccountType, Map<String, Account>> accounts = {};
  Accounts() {
    storage.read(key: "leaf");
  }

  addAccount(AccountType type, String username, String password) async {
    if (isReady) {
      if (type == AccountType.leaf) {
        var id = uuid.v4();
        print("test");
        Account account = await Leaf.createWithLogin(id, username, password);
        if (accounts[type] == null) accounts[type] = {};
        accounts[type]?.addAll({id: account});
        saveAccounts();
      }
    }
  }

  remove(String id) {
    accounts = accounts.map((key, value) {
      value.removeWhere((key, value) => value.id == id);
      return MapEntry(key, value);
    });
  }

  saveAccounts() async {
    if (isReady) {
      accounts.forEach((key, value) {
        print(json.encode(value));
        storage.write(key: key.name, value: json.encode(value));
      });
    } else {
      throw "Accounts aren't ready. Run [getAccounts] first.";
    }
  }

  Future<Map<AccountType, Map<String, Account>>> getAccounts() async {
    if (!isReady) {
      var data = await storage.readAll();
      accounts = data.map((key, value) {
        AccountType type =
            AccountType.values.firstWhere((element) => element.name == key);

        return MapEntry(
            type,
            (json.decode(value) as Map<String, dynamic>).map((id, value) =>
                MapEntry(id, type.json(<String, String>{"id": id, ...value}))));
      });
      isReady = true;
    }
    return accounts;
  }
}

class Account {
  String id;

  String username;
  String password;

  DateTime lastUpdated;

  Account(
      {required this.id,
      required this.username,
      required this.password,
      required this.lastUpdated});

  @override
  String toString() {
    return json.encode({
      "id": id,
      "username": username,
      "password": password,
      "lastUpdated": lastUpdated.millisecondsSinceEpoch
    });
  }

  static Account parse(String string) {
    return fromJson(json.decode(string));
  }

  static Account fromJson(dynamic data) {
    return Account(
        id: data['id'],
        username: data['username'],
        password: data['password'],
        lastUpdated: DateTime.fromMillisecondsSinceEpoch(data['lastUpdated']));
  }

  Future<double> getCharge() async {
    throw 'Unimplemented';
  }

  Map toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "lastUpdated": lastUpdated.millisecondsSinceEpoch
      };
}

enum AccountType {
  leaf(type: Leaf, parser: Leaf.parse, json: Leaf.fromJson);

  const AccountType(
      {required this.type, required this.parser, required this.json});
  final Type type;
  final Account Function(String) parser;
  final Account Function(dynamic) json;
}
