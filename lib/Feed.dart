import 'package:flutter/material.dart';
import 'Crud/UserDL.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({Key? key}) : super(key: key);

  @override
  State<HomeFeed> createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  String? s = UserDL.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Text('$s'),

      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        elevation: 4.0,
        child: Icon(Icons.add),
      ),
    );
  }
}

