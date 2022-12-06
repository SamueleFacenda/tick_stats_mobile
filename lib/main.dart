import 'package:flutter/material.dart';

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
      ),
      home: const MyHomePage(title: 'TickStats'),
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
