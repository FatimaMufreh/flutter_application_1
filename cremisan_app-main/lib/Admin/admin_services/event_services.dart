import 'package:cloud_firestore/cloud_firestore.dart';
import '../admin_models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('events');

class FirebaseEvent {
  static Future<Response> addEvent(
      {required String nameEn,
      required String nameAr,
      required String infoEn,
      required String infoAr,
      required String image,
      required String eventCategoryEn,
      required String eventCategoryAr,
      required String placeEn,
      required String placeAr,
      required String addressEn,
      required String addressAr,
      required String date,
      required String time,
      required String location_url,
      required String phoneNo}) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      'name': {'en': nameEn, 'ar': nameAr},
      'info': {'en': infoEn, 'ar': infoAr},
      'image': image,
      'event_category': {'en': eventCategoryEn, 'ar': eventCategoryAr},
      'place': {'en': placeEn, 'ar': placeAr},
      'address': {'en': addressEn, 'ar': addressAr},
      'date': date,
      'time': time,
      'location_url': location_url,
      'phoneNo': phoneNo
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
  ////////////////////////////////
  ///
  // Read Event records

  static Stream<QuerySnapshot> readEvent() {
    CollectionReference notesItemCollection = _Collection;

    return notesItemCollection.snapshots();
  }
////////////////////////////////////
  ///Update employee record

  static Future<Response> updateEvent(
      {required String nameEn,
      required String nameAr,
      required String infoEn,
      required String infoAr,
      required String image,
      required String eventCategoryEn,
      required String eventCategoryAr,
      required String placeEn,
      required String placeAr,
      required String addressEn,
      required String addressAr,
      required String date,
      required String time,
      required String location_url,
      required String docId,
      required String phoneNo}) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      'name': {'en': nameEn, 'ar': nameAr},
      'info': {'en': infoEn, 'ar': infoAr},
      'image': image,
      'event_category': {'en': eventCategoryEn, 'ar': eventCategoryAr},
      'place': {'en': placeEn, 'ar': placeAr},
      'address': {'en': addressEn, 'ar': addressAr},
      'date': date,
      'time': time,
      'location_url': location_url,
      'phoneNo': phoneNo
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated this event";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
  //////////////////////
  ///Delete Event record

  static Future<Response> deleteEvent({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully Deleted Event";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
