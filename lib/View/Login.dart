import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                label: Text("Username"),
                // enabledBorder: OutlineInputBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(25)))
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                label: Text("Password"),
              ),
            ),
            Row(
              children: [
                ElevatedButton(onPressed: () {}, child: const Text("Login"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
