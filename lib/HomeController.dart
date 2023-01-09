import 'Graph.dart';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'RouteGenerator.dart';
import 'Feed.dart';
import 'Notifications.dart';
import 'Search.dart';
import 'Profile.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  String? email;
  MyHomePage( this.email, {Key? key,}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState(email);
}

class _MyHomePageState extends State<MyHomePage> {

  String? email;
  _MyHomePageState(this.email);

  int idx = 0;
  var list = [
    const HomeFeed(),
    const NotificationPage(),
    const UserGraph(),
    const SearchPage(),
    const ProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.teal,

          title: const Text(
            'theKomraid',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
      ),
      body: Center(
        child: list[idx],
      ),



      bottomNavigationBar: BottomNavigationBar(

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq),
            label: 'Graph',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],


        currentIndex: idx,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.teal,
        onTap: (int index) {
          setState(() {
            idx = index;
          });
        },

      ),
    );
  }
}