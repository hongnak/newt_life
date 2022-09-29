import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newt_life/data_kind.dart';

class AddDataModel extends ChangeNotifier {
  String? name;
  String? size;
  String? memo;
  String? kind;
  String? category;
  String? userID;
  double temperature = 26.0;
  int amountInt = 1;
  dynamic amount;
  var myDateTime = DateTime.now();
  final picker = ImagePicker();
  File? imageFile;
  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setDate(DateTime dateTime) {
    myDateTime = dateTime;
    notifyListeners();
  }

  void setAmount(dynamic value) {
    amount = value;
    notifyListeners();
  }

  void setAmountInt(int value) {
    amountInt = value;
    notifyListeners();
  }

  void setTemperature(double value) {
    temperature = value;
    notifyListeners();
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future addOrEditData(String id, String collectionName) async {
    final doc = FirebaseFirestore.instance.collection('tank').doc(id);
    String? imgURL;

    if (imageFile != null) {
      final task = await FirebaseStorage.instance.ref('aquarium/${doc.id}').putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
    }

    switch (dataKind) {
      case DataKind.creature:
        if (name == null || name == '') throw '生き物の名前が入力されていません';
        if (category == null || category == '') throw '生き物のカテゴリーが選択されていません';
        if (kind == null || kind == '') throw '生き物の種類が入力されていません';
        break;
      case DataKind.plant:
        if (name == null || name == '') throw '水草の名前が入力されていません';
        if (category == null || category == '') throw '水草のカテゴリーが選択されていません';
        if (kind == null || kind == '') throw '水草の種類が入力されていません';
        break;
      case DataKind.waterChange:
        if (amount == null || amount == '') throw '水換え量が選択されていません';
        break;
      case DataKind.feed:
        if (amount == null || amount == '') throw '餌やり量が選択されていません';
        break;
      case DataKind.temperature:
        break;
      case DataKind.diary:
        if (memo == null || memo == '') throw '日記が入力されていません';
        break;
    }

    await doc.collection(collectionName).doc().set({
      if (name != null) 'name' : name,
      if (category != null) 'category' : category,
      if (kind != null) 'kind' : kind,
      if (amount != null) 'amount' : amount,
      if (dataKind == DataKind.creature || dataKind == DataKind.plant) 'amount' : amountInt,
      if (dataKind == DataKind.temperature) 'temperature' : temperature,
      'imgURL' : imgURL ?? '',
      'memo' : memo ?? '',
      'registrationDate' : myDateTime,
      'lastUpdatedDate' : myDateTime,
    });

    notifyListeners();
  }
}