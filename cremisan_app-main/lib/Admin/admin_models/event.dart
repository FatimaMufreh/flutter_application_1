import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String? nameEn;
  String? nameAr;
  String? infoEn;
  String? infoAr;
  String? image;
  String? eventCategoryEn;
  String? eventCategoryAr;
  String? placeEn;
  String? placeAr;
  String? addressEn;
  String? addressAr;
  String? date;
  String? time;
  String? location_url;
  String? phoneNo;
  String? docId;

  Event(
      {this.docId,
      this.image,
      this.addressAr,
      this.addressEn,
      this.date,
      this.eventCategoryAr,
      this.eventCategoryEn,
      this.infoAr,
      this.infoEn,
      this.location_url,
      this.nameAr,
      this.nameEn,
      this.placeAr,
      this.placeEn,
      this.time,
      this.phoneNo});

  // formatting for upload to Firebase when creating the event
  Map<String, dynamic> toJson() => {
        'docId': docId,
        'image': image,
        'location_url': location_url,
        'time': time,
        'placeEn': placeEn,
        'placeAr': placeAr,
        'nameEn': nameEn,
        'nameAr': nameAr,
        'infoEn': infoEn,
        'infoAr': infoAr,
        'eventCategoryEn': eventCategoryEn,
        'eventCategoryAr': eventCategoryAr,
        'date': date,
        'addressEn': addressEn,
        'addressAr': addressAr,
        'phoneNo': phoneNo
      };

  Event.fromSnapshot(DocumentSnapshot snapshot)
      : docId = snapshot['docId'],
        image = snapshot['image'],
        location_url = snapshot['location_url'],
        time = snapshot['time'],
        placeEn = snapshot['placeEn'],
        placeAr = snapshot['placeAr'],
        nameEn = snapshot['nameEn'],
        nameAr = snapshot['nameAr'],
        infoEn = snapshot['infoEn'],
        infoAr = snapshot['infoAr'],
        eventCategoryEn = snapshot['eventCategoryEn'],
        eventCategoryAr = snapshot['eventCategoryAr'],
        date = snapshot['date'],
        addressEn = snapshot['addressEn'],
        phoneNo = snapshot['phoneNo'],
        addressAr = snapshot['addressAr'];
}
