import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newt_life/domain/tank.dart';

class TankListModel extends ChangeNotifier {
  List<Tank>? tanks;
  String? userID;

  void fetchTankList() async {

    if (FirebaseAuth.instance.currentUser != null) {
      final user = FirebaseAuth.instance.currentUser;
      userID = user?.uid;
    }

    if (userID != null) {
      QuerySnapshot snapshot;
      snapshot = await FirebaseFirestore.instance.collection('tank').where('userID', whereIn: [userID]).get(const GetOptions(source: Source.cache));
      if (snapshot.docs.isEmpty) {
        snapshot = await FirebaseFirestore.instance.collection('tank').where('userID', whereIn: [userID]).get(const GetOptions(source: Source.server));
      }
      final List<Tank> tanks;
      tanks = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        final String name = data['name'];
        final String size = data['size'];
        final String memo = data['memo'];
        final String imgURL = data['imgURL'];
        final String id = document.id;
        final Timestamp registrationDate = data['registrationDate'];
        final Timestamp lastUpdatedDate = data['lastUpdatedDate'];
        return Tank(name, size, memo, imgURL, id, registrationDate, lastUpdatedDate);
      }).toList();

      tanks.sort((a, b) => b.registrationDate.compareTo(a.registrationDate));
      this.tanks = tanks;
      notifyListeners();
    }
  }
}