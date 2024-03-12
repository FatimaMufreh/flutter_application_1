import 'package:cloud_firestore/cloud_firestore.dart';

class Animal {
  String? uid;
  String? image;
  String? ar_name;
  String? ar_info;
  String? en_name;
  String? en_info;
  String? en_animal_category;
  String? ar_animal_category;

  Animal(
      {this.uid,
      this.image,
      this.ar_name,
      this.ar_info,
      this.en_name,
      this.en_info,
      this.en_animal_category,
      this.ar_animal_category});

  // formatting for upload to Firbase when creating the trip
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'image': image,
        'ar_name': ar_name,
        'ar_info': ar_info,
        'en_name': en_name,
        'en_info': en_info,
        'en_animal_category': en_animal_category,
        'ar_animal_category': ar_animal_category
      };

  Animal.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot['uid'],
        image = snapshot['image'],
        ar_name = snapshot['ar_name'],
        ar_info = snapshot['ar_info'],
        en_name = snapshot['en_name'],
        en_info = snapshot['en_info'],
        en_animal_category = snapshot['en_animal_category'],
        ar_animal_category = snapshot['ar_animal_category'];
}
