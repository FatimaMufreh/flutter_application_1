import 'package:cloud_firestore/cloud_firestore.dart';

class Plant {
  String? uid;
  String? image;

  String? en_name;
  String? ar_name;

  String? en_info;
  String? ar_info;

  String? en_plant_category;
  String? ar_plant_category;
  String? en_species_name;

  String? ar_species_name;
  String? en_family;

  String? ar_family;
  Plant(
      {this.uid,
      this.image,
      this.en_name,
      this.ar_name,
      this.en_info,
      this.ar_info,
      this.en_plant_category,
      this.ar_plant_category,
      this.en_species_name,
      this.ar_species_name,
      this.en_family,
      this.ar_family});

  // formatting for upload to Firbase when creating the trip
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'image': image,
        'en_name': en_name,
        'ar_name': ar_name,
        'en_info': en_info,
        'ar_info': ar_info,
        'en_plant_category': en_plant_category,
        'ar_plant_category': ar_plant_category,
        'en_species_name': en_species_name,
        'ar_species_name': ar_species_name,
        'en_family': en_family,
        'ar_family': ar_family,
      };

  Plant.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot['uid'],
        image = snapshot['image'],
        en_name = snapshot['en_name'],
        ar_name = snapshot['ar_name'],
        en_info = snapshot['en_info'],
        ar_info = snapshot['ar_info'],
        en_plant_category = snapshot['en_plant_category'],
        ar_plant_category = snapshot['ar_plant_category'],
        en_species_name = snapshot['en_species_name'],
        ar_species_name = snapshot['ar_species_name'],
        en_family = snapshot['en_family'],
        ar_family = snapshot['ar_family'];
}
