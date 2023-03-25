import 'package:flutter/material.dart';
import 'package:leafwatch/accounts.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Login",
            textScaleFactor: 3,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ElevatedButton(
                  child: const Text("Leaf"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreenWidget(
                                  title: "Leaf",
                                )));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LoginScreenWidget extends StatefulWidget {
  const LoginScreenWidget({super.key, required this.title});

  final String title;

  @override
  State<LoginScreenWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreenWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _buttonEnabled = true;
  // Navigator.of(context)

  @override
  Widget build(context) {
    var page = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login to ${widget.title}",
                textScaleFactor: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 50, right: 50, top: 25),
                child: Column(children: [
                  // TODO: Use password manager compatible fields
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Username"),
                    ),
                  ),
                  Container(
                    width: 500,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Password"),
                    ),
                  ),
                  SizedBox(
                      width: 500,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: !_buttonEnabled
                            ? null
                            : () async {
                                setState(() {
                                  _buttonEnabled = false;
                                });
                                try {
                                  await Accounts.instance.addAccount(
                                      AccountType.leaf,
                                      nameController.text,
                                      passwordController.text);

                                  page.pop();
                                  return;
                                } catch (ignored) {
                                  setState(() {
                                    _buttonEnabled = false;
                                  });
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            content: const Text(
                                                "An error occurred whilst logging, maybe you misspelt your username or password?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text("OK"))
                                            ],
                                          ));
                                }
                                setState(() {
                                  _buttonEnabled = true;
                                });
                              },
                        child: const Text('Login'),
                      )),
                ]),
              )
            ],
          )),
    );
  }
}
