import 'package:cloud_firestore/cloud_firestore.dart';

class Tank {
  Tank(this.name, this.size, this.memo, this.imgURL, this.id, this.registrationDate, this.lastUpdatedDate);
  String name;
  String size;
  String memo;
  String imgURL;
  String id;
  Timestamp registrationDate;
  Timestamp lastUpdatedDate;
}