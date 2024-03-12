import 'package:cloud_firestore/cloud_firestore.dart';
import '../admin_models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection('plants');

class FirebasePlant {
  static Future<Response> addPlant({
    required String image,
    required String en_name,
    required String ar_name,
    required String en_info,
    required String ar_info,
    required String en_plant_category,
    required String ar_plant_category,
    required String en_species_name,
    required String ar_species_name,
    required String en_family,
    required String ar_family,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      'image': image,
      'name': {'en': en_name, 'ar': ar_name},
      'info': {'en': en_info, 'ar': ar_info},
      'plant_category': {'en': en_plant_category, 'ar': ar_plant_category},
      'species_name': {'en': en_species_name, 'ar': ar_species_name},
      'family': {'en': en_family, 'ar': ar_family},
    };

    await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = 'Successfully added to the database';
    }).catchError((e) {
      response.code = 500;
      response.message = e.toString();
    });

    return response;
  }

  static Stream<QuerySnapshot> readPlant() {
    return _collection.snapshots();
  }

  static Future<Response> updatePlant({
    required String image,
    required String en_name,
    required String ar_name,
    required String en_info,
    required String ar_info,
    required String en_plant_category,
    required String ar_plant_category,
    required String en_species_name,
    required String ar_species_name,
    required String en_family,
    required String ar_family,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      'image': image,
      'name': {'en': en_name, 'ar': ar_name},
      'info': {'en': en_info, 'ar': ar_info},
      'plant_category': {'en': en_plant_category, 'ar': ar_plant_category},
      'species_name': {'en': en_species_name, 'ar': ar_species_name},
      'family': {'en': en_family, 'ar': ar_family},
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = 'Successfully updated Plant';
    }).catchError((e) {
      response.code = 500;
      response.message = e.toString();
    });

    return response;
  }

  static Future<Response> deletePlant({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = 'Successfully deleted this plant';
    }).catchError((e) {
      response.code = 500;
      response.message = e.toString();
    });

    return response;
  }
}
