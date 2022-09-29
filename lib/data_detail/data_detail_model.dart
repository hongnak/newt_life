import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newt_life/data_kind.dart';

class DetailDataModel extends ChangeNotifier {
  DetailDataModel({Key? key, required this.tankID, required this.docID});
  final String tankID;
  final String docID;
  String? name;
  String? size;
  String? memo;
  String? kinds;
  String? category;
  String? imgURL;
  String? userID;
  double temperature = 26.0;
  int amountInt = 1;
  dynamic amount;
  var myDateTime = DateTime.now();
  DateTime? lastUpdatedDate;
  DateTime? registrationDate;
  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future fetchData() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot;
    snapshot = await FirebaseFirestore.instance.collection('tank').doc(tankID).collection(collectionName).doc(docID).get(const GetOptions(source: Source.cache));
    if (!snapshot.exists) {
      snapshot = await FirebaseFirestore.instance.collection('tank').doc(tankID).collection(collectionName).doc(docID).get(const GetOptions(source: Source.server));
    }

    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    if (dataKind == DataKind.creature || dataKind == DataKind.plant || dataKind == DataKind.diary ) imgURL = data['imgURL'];
    if (dataKind == DataKind.creature || dataKind == DataKind.plant) name = data['name'];
    if (dataKind == DataKind.creature || dataKind == DataKind.plant) kinds = data['kind'];
    if (dataKind == DataKind.creature || dataKind == DataKind.plant) category = data['category'];
    if (dataKind == DataKind.creature || dataKind == DataKind.plant) amountInt = data['amount'];
    if (dataKind == DataKind.waterChange || dataKind == DataKind.feed) amount = data['amount'];
    if (dataKind == DataKind.temperature) temperature = data['temperature'];
    memo = data['memo'];
    registrationDate = data['registrationDate'].toDate();
    lastUpdatedDate = data['lastUpdatedDate'].toDate();
    notifyListeners();
  }

  Future deleteData() async {
    final doc = FirebaseFirestore.instance.collection('tank').doc(tankID).collection(collectionName).doc(docID);
    await doc.delete();
    notifyListeners();
  }

}