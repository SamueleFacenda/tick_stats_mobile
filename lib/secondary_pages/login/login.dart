import 'package:flutter/material.dart';
import 'package:tick_stats_mobile/backend/communicator.dart';
import 'package:tick_stats_mobile/secondary_pages/smallComponents.dart';

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
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Login to Tickstats',
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
            ElevatedButton(
              onPressed: () {
                _tryLogin();
              },
              child: const Text('Login'),
            ),
            if (_isServerUnreachable) const Text('Server unreachable', style: TextStyle(color: Colors.red)),
            if (_isWrongCredentials) const Text('Wrong credentials', style: TextStyle(color: Colors.red)),
            if (_isLoginInProgress) const CircularProgressIndicator(),
            const SizedBox(height: 20),
            HyperLink(
              text: 'If you don\'t have an account, you can ',
              hypertext: 'sign in.',
              onPressed: () async {
                Navigator.pushReplacementNamed(context, '/register');
              },
            ),
          ],
        ),)
      ,
    ),);
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
          setState(() {
            _isLoginInProgress = false;
          });
    });
  }
}
