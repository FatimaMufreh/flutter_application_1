import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? uid;
  String? arabic_name;
  String? english_name;

  String? image;

  CategoryModel({this.uid, this.arabic_name, this.english_name, this.image});

  // formatting for upload to Firbase when creating the trip
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'arabic_name': arabic_name,
        'english_name': english_name,
        'image': image
      };

  CategoryModel.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot['uid'],
        arabic_name = snapshot['arabic_name'],
        english_name = snapshot['english_name'],
        image = snapshot['image'];
}
