import 'dart:io';
import 'Crud/ImageDL.dart';
import 'package:myapp/Crud/UserDL.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? imageUrl= UserDL.imageUrl;
  String? name = UserDL.name;
  String? email = UserDL.email;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: ()async{
                  XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                  imageUrl = await ImageDL.AddImage(image);
                  setState(() {
                    imageUrl = imageUrl;
                  });
                  UserDL.AddProfileImage(imageUrl);
              },
                child:

                Container(
                  margin: const EdgeInsets.only(left: 20, top: 20),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: Image.network(imageUrl.toString()).image,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  children:  [
                    Text(
                      name.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      email.toString(),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
