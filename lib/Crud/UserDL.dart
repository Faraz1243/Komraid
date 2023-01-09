// ignore_for_file: non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class UserDL {
  static String email = "";
  static String? name = "";
  static String? imageUrl = "";
  // static String?
  static Future<bool> AddUser(String name, String email, String password) async {
    // ignore: unrelated_type_equality_checks
    CollectionReference users = FirebaseFirestore.instance.collection("Users");
    final data = <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'posts': [],
      'friends': 0,
      'profile_pic': "",
      'bio': "",
      'requests': [],
    };
    users.add(data);
    return true;
  }

  static Future<bool> CheckEmail(String email) async {
    await Firebase.initializeApp();
    var result = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: email)
        .get();
    if (result.docs.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static AddProfileImage(String? url) async {
    imageUrl = url;
    CollectionReference users = FirebaseFirestore.instance.collection("Users");
    await users
        .where('email', isEqualTo: email)
        .get()
        .then((value) => value.docs.forEach((element) {
              element.reference.update({'profile_pic': url});
            }));
  }

  static Future<dynamic> Login(String email, String password) async {
    await Firebase.initializeApp();
    var result = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();
    result.size;
    if (result.docs.isEmpty) {
      return "null";
    } else {
      name = result.docs[0].data()['name'];
      UserDL.email = result.docs[0].data()['email'];
      imageUrl = result.docs[0].data()['profile_pic'];

      return result.docs[0].data()['email'];
    }
  }

  static Future<dynamic> SearchQuery(String s) async {
    var v = await FirebaseFirestore.instance
        .collection('Users')
        .where('name', isEqualTo: s)
        .get();
    return v.docs;
  }

  static Future<dynamic> GetUserData(String email) async {
    var v = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: email)
        .get();
    return v.docs[0].data();
  }

  static Future<dynamic> GetRequests() async {
    var v = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: email)
        .get();
    var emails = v.docs[0].data()['requests'];           //////////////////////////
    var users = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', whereIn: emails)
        .get();
    return users.docs;
  }

  static Future<dynamic> GetAllUsers() async {
    var v = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isNotEqualTo: "...")
        .get();
    return v.docs;
  }
}
