import 'package:cloud_firestore/cloud_firestore.dart';
import '../admin_models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _categoriesCollection =
    _firestore.collection('animal_categories');

class FirebaseAnimalCategories {
  static Future<Response> addCategory({
    required String nameEn,
    required String nameAr,
    required String image,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _categoriesCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "name": {"en": nameEn, "ar": nameAr},
      "image": image,
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Successfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e.toString();
    });

    return response;
  }

  static Stream<QuerySnapshot> readCategory() {
    CollectionReference categoriesItemCollection = _categoriesCollection;

    return categoriesItemCollection.snapshots();
  }

  static Future<Response> updateCategory({
    required String nameEn,
    required String nameAr,
    required String image,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _categoriesCollection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "name": {"en": nameEn, "ar": nameAr},
      "image": image,
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Successfully updated category";
    }).catchError((e) {
      response.code = 500;
      response.message = e.toString();
    });

    return response;
  }

  static Future<Response> deleteCategory({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _categoriesCollection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Successfully deleted category";
    }).catchError((e) {
      response.code = 500;
      response.message = e.toString();
    });

    return response;
  }
}
