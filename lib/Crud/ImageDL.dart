import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageDL{
  static Future<String?> AddImage(XFile? image) async{
    String url = "";
    if(image!=null) {
      String uniqueName = Uuid().v4();
      // String uniqueName = DateTime.fromMicrosecondsSinceEpoch.toString();

      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceFolder = referenceRoot.child("Images");
      Reference referenceImage = referenceFolder.child(uniqueName);

      try{
        await referenceImage.putFile(File(image!.path));
        url = await referenceImage.getDownloadURL();
      }
      // ignore: empty_catches
      catch(error){ }
    }
    return url;
  }
}