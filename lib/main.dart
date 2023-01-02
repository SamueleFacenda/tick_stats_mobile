import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tick_stats_mobile/secondary_pages/login/login.dart';
import 'package:tick_stats_mobile/secondary_pages/register/register.dart';

// adb connect 127.0.0.1:58526
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'TickStats'),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadPersistency();
  }

  void _loadPersistency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool logged = prefs.getBool('logged') ?? false;
    if (!logged) {
      prefs.setBool('logged', false);
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Builder(builder: (BuildContext context) {
          return BottomNavigationBar(
            currentIndex: _selectedIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.insert_comment_rounded), label: 'insert'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart_rounded), label: 'chart'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_rounded), label: 'settings'),
            ],
            onTap: (index) {
              DefaultTabController.of(context)!.animateTo(index);
              setState(() {
                _selectedIndex = index;
              });
            },
          );
        }),
        body: const TabBarView(
          children: [
            Text('aggiungi tickstats'),
            Text('visualizza grafici'),
            Text('impostazioni'),
          ],
        ),
      ),
    );
  }
}
