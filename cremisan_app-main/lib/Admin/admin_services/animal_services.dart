import 'package:cloud_firestore/cloud_firestore.dart';
import '../admin_models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection('animals');

class FirebaseAnimal {
  static Future<Response> addAnimal({
    required String nameEn,
    required String nameAr,
    required String infoEn,
    required String infoAr,
    required String image,
    required String animalCategoryEn,
    required String animalCategoryAr,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      'name': {'en': nameEn, 'ar': nameAr},
      'info': {'en': infoEn, 'ar': infoAr},
      'image': image,
      'animal_category': {'en': animalCategoryEn, 'ar': animalCategoryAr},
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

  static Stream<QuerySnapshot> readAnimal() {
    return _collection.snapshots();
  }

  static Future<Response> updateAnimal({
    required String nameEn,
    required String nameAr,
    required String infoEn,
    required String infoAr,
    required String image,
    required String animalCategoryEn,
    required String animalCategoryAr,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      'name': {'en': nameEn, 'ar': nameAr},
      'info': {'en': infoEn, 'ar': infoAr},
      'image': image,
      'animal_category': {'en': animalCategoryEn, 'ar': animalCategoryAr},
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = 'Successfully updated Animal';
    }).catchError((e) {
      response.code = 500;
      response.message = e.toString();
    });

    return response;
  }

  static Future<Response> deleteAnimal({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = 'Successfully deleted Animal';
    }).catchError((e) {
      response.code = 500;
      response.message = e.toString();
    });

    return response;
  }
}
