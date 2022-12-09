import 'package:flutter/material.dart';
import 'package:tick_stats_mobile/backend/communicator.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nameController = TextEditingController(),
      passwordController = TextEditingController();
  bool _isServerUnreachable = false,
      _isWrongCredentials = false,
      _isLoginInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login to Tickstats'),
            ElevatedButton(
              onPressed: () {
                _tryLogin();
              },
              child: const Text('Login'),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                  hintText: 'Enter valid mail id as abc@gmail.com'),
            ),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter your secure password'),
            ),
            if (_isServerUnreachable) const Text('Server unreachable'),
            if (_isWrongCredentials) const Text('Wrong credentials'),
            if (_isLoginInProgress) const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  void _tryLogin() {
    setState(() {
      _isLoginInProgress = true;
    });

    Communicator()
        .login(nameController.text, passwordController.text)
        .then((statusCode) {
      //custom status code
      switch (statusCode) {
        case 0:
          //login successful
          setState(() {
            _isLoginInProgress = false;
          });
          Navigator.pushReplacementNamed(context, '/');
          break;
        case 401:
          //wrong credentials
          setState(() {
            _isWrongCredentials = true;
          });
          break;
        case 600:
          //server unreachable
          setState(() {
            _isServerUnreachable = true;
          });
          break;
        case 500:
          //server error
          break;
      }
    });
    setState(() {
      _isLoginInProgress = false;
    });
  }
}
