import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:leafwatch/remote.dart';

class Accounts {
  static Accounts instance = Accounts();

  var accounts = <Account>[];
  Accounts() {
    const storage = FlutterSecureStorage();
    print(storage);
    storage.read(key: "leaf");
  }

  addAccount(AccountType type, String username, String password) async {
    if (type == AccountType.leaf) {
      Leaf account = await Leaf.login(username, password);
    }
  }
}

class Account {}

enum AccountType { leaf }
