import 'package:flutter/material.dart';

class InsertWidget extends StatefulWidget {
  const InsertWidget({Key? key}) : super(key: key);

  @override
  State<InsertWidget> createState() => _InsertWidgetState();
}

class _InsertWidgetState extends State<InsertWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Insert'),
        ],
      ),
    );
  }
}
