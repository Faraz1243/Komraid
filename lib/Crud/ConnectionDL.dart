import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Crud/UserDL.dart';


class ConnectionDL{
  static Future<void> addConnection(String email) async{
    CollectionReference users = FirebaseFirestore.instance.collection("Users");
    await users.where('email', isEqualTo: UserDL.email).get().then((value) => value.docs.forEach((element) {
      element.reference.update({'requests': FieldValue.arrayRemove([email])});
    }));
    await FirebaseFirestore.instance.collection('Connections').add({
      'friend1': UserDL.email,
      'friend2': email,
    });
  }
  static Future<bool> isConnection(String email1, String email2) async{
    var result = await FirebaseFirestore.instance.collection('Connections').where('friend1', isEqualTo: email1)
        .where('friend2', isEqualTo: email2).get();
    if(result.docs.isEmpty){
      result = await FirebaseFirestore.instance.collection('Connections').where('friend1', isEqualTo: email2)
          .where('friend2', isEqualTo: email1).get();
      if(result.docs.isEmpty){
        return false;
      }
      else{
        return true;
      }
    }
    return true;
  }
  static Future<void> removeConnection(String email) async{
    await FirebaseFirestore.instance.collection('Connections').where('friend1', isEqualTo: UserDL.email)
        .where('friend2', isEqualTo: email).get().then((value) => value.docs.forEach((element) {
      element.reference.delete();
    }));
    await FirebaseFirestore.instance.collection('Connections').where('friend2', isEqualTo: UserDL.email)
        .where('friend1', isEqualTo: email).get().then((value) => value.docs.forEach((element) {
      element.reference.delete();
    }));
  }


  static Future<void> removeRequest(String email1) async{
    //remove email from 'requests array'
    FirebaseFirestore.instance.collection('Users').where('email', isEqualTo: email1).get().then((value) => value.docs.forEach((element) {
      element.reference.update({'requests': FieldValue.arrayRemove([UserDL.email])});
    }));
  }
  static Future<void> sendRequest(String email) async{
    FirebaseFirestore.instance.collection('Users').where('email', isEqualTo: email).get().then((value) => value.docs.forEach((element) {
      element.reference.update({'requests': FieldValue.arrayUnion([UserDL.email])});
    }));
  }
  static Future<bool> isRequestSent(String email) async{
    var result = await FirebaseFirestore.instance.collection('Users').where('email', isEqualTo: email).get();
    if(result.docs[0].data()['requests'].contains(UserDL.email)){
      return true;
    }
    else{
      return false;
    }
  }
  static Future<bool> wasRequestReceived(String email) async{
    var result = await FirebaseFirestore.instance.collection('Users').where('email', isEqualTo: UserDL.email).get();
    if(result.docs[0].data()['requests'].contains(email)){
      return true;
    }
    else{
      return false;
    }
  }

  static Future<dynamic> getAllConnections() async{
    //get all documents in firebase collection 'Connections' where friend1 = email
    var result = await FirebaseFirestore.instance.collection('Connections').get();
    return result.docs;
  }
}