import 'package:flutter/material.dart';
import 'package:tick_stats_mobile/backend/communicator.dart';
import 'package:tick_stats_mobile/secondary_pages/smallComponents.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController(),
      passwordController = TextEditingController(), passwordController2 = TextEditingController();
  bool _isServerUnreachable = false,
      _isWrongCredentials = false,
      _isLoginInProgress = false,
      _isPasswordNotMatching = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Sign to Tickstats',
                style: textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name'),
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              controller: passwordController2,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Repeat Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _tryLogin();
              },
              child: const Text('submit'),
            ),
            if (_isServerUnreachable) const Text('Server unreachable', style: TextStyle(color: Colors.red)),
            if (_isWrongCredentials) const Text('Username already taken', style: TextStyle(color: Colors.red)),
            if (_isPasswordNotMatching) const Text('Passwords don\'t match', style: TextStyle(color: Colors.red)),
            if (_isLoginInProgress) const CircularProgressIndicator(),
            HyperLink(
              text: 'If you already have an account, you can ',
              hypertext: 'log in.',
              onPressed: () async {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
          ),
        ),
      ),
    );
  }

  void _tryLogin() {
    if (nameController.text.isEmpty || passwordController.text.isEmpty || passwordController.text != passwordController2.text) {
      setState(() {
        _isPasswordNotMatching = true;
      });
      return;
    }

    setState(() {
      _isLoginInProgress = true;
    });

    Communicator()
        .register(nameController.text, passwordController.text)
        .then((statusCode) {
          //custom status code
          switch (statusCode) {
            case 0:
            //login successful
              Navigator.pushReplacementNamed(context, '/');
              break;
            case 400:
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
          setState(() {
            _isLoginInProgress = false;
          });
    });
  }
}
