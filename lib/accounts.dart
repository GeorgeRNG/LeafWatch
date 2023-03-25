import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:leafwatch/remote.dart';

class Accounts {
  static Accounts instance = Accounts();
  FlutterSecureStorage storage = const FlutterSecureStorage();

  var accounts = <Account>[];
  Accounts() {
    storage.read(key: "leaf");
  }

  addAccount(AccountType type, String username, String password) async {
    Account account;
    if (type == AccountType.leaf) {
      account = await Leaf.login(username, password);
    }
    List<String> accounts;
    if (await storage.containsKey(key: type.name)) {
      accounts = [account];
    } else {
      // accounts =
    }
  }
}

class Account {
  String username;
  String password;

  Account({required this.username, required this.password});

  @override
  String toString() {
    return jsonEncode({username, password});
  }

  Future<String> getData() {
    return Future.value(toString());
  }
}

enum AccountType {
  leaf(type: Leaf);

  const AccountType({required this.type});
  final Type type;
}
