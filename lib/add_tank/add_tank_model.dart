import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddTankModel extends ChangeNotifier {
  String? name;
  String? size;
  String? memo;
  String? userID;
  bool isLoading = false;
  var myDateTime = DateTime.now();
  final picker = ImagePicker();
  File? imageFile;

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future addOrEditData(String id, String collectionName) async {
    if (name == null || name == '') throw '水槽の名前が入力されていません';
    if (size == null || size == '') throw '水槽のサイズが入力されていません';
    final doc = FirebaseFirestore.instance.collection('tank').doc();
    String? imgURL;

    if (imageFile != null) {
      final task = await FirebaseStorage.instance.ref('tank/${doc.id}').putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
    }

    if (FirebaseAuth.instance.currentUser != null) {
      final user = FirebaseAuth.instance.currentUser;
      userID = user?.uid;
      await doc.set({
        'userID' : userID,
        'name' : name,
        'size' : size,
        'memo' : memo ?? '記録なし',
        'imgURL' : imgURL ?? '',
        'registrationDate' : myDateTime,
        'lastUpdatedDate' : myDateTime,
      });
      notifyListeners();
    }
  }

}