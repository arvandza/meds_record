import 'package:cloud_firestore/cloud_firestore.dart';

class AccessRequestModel {
  String? requestId;
  String idOwner;
  String? name;
  String nik;
  String instansiName;
  String keperluan;
  String medicalRecordId;
  String status;

  AccessRequestModel(
      {this.requestId,
      required this.idOwner,
      this.name,
      required this.nik,
      required this.instansiName,
      required this.medicalRecordId,
      required this.keperluan,
      required this.status});

  factory AccessRequestModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return AccessRequestModel(
        requestId: doc['requestId'],
        idOwner: doc['idOwner'],
        name: doc['name'],
        nik: doc['nik'],
        instansiName: doc['instansiName'],
        medicalRecordId: doc['medicalRecordId'],
        keperluan: doc['keperluan'],
        status: doc['status']);
  }

  Map<String, dynamic> toMap() {
    return {
      'requestId': requestId,
      'name': name,
      'idOwner': idOwner,
      'nik': nik,
      'instansiName': instansiName,
      'medicalRecordId': medicalRecordId,
      'keperluan': keperluan,
      'status': status
    };
  }
}
