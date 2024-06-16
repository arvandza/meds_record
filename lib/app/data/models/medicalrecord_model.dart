import 'package:cloud_firestore/cloud_firestore.dart';

class MedicalrecordModel {
  String? recordId;
  String? patientId;
  String? name;
  String? nik;
  DateTime? date;
  String? diseaseHistory;
  String? diagnosis;
  String? recordNumber;
  String? location;
  String? pdfUrl;
  String? publicKey;
  String? aesKey;
  String? macBytes;
  String? aesNonce;
  String? cipherText;

  MedicalrecordModel(
      {this.recordId,
      this.patientId,
      this.name,
      this.nik,
      this.date,
      this.diseaseHistory,
      this.diagnosis,
      this.recordNumber,
      this.location,
      this.pdfUrl,
      this.publicKey,
      this.aesKey,
      this.macBytes,
      this.aesNonce,
      this.cipherText});

  factory MedicalrecordModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    Timestamp? timestamp = doc['date'];
    DateTime? date = timestamp?.toDate();
    return MedicalrecordModel(
        recordId: doc['recordId'],
        patientId: doc['patientId'],
        name: doc['name'],
        nik: doc['nik'],
        date: date,
        diseaseHistory: doc['diseaseHistory'],
        diagnosis: doc['diagnosis'],
        recordNumber: doc['recordNumber'],
        location: doc['location'],
        pdfUrl: doc['pdfUrl'],
        publicKey: doc['publicKey'],
        aesKey: doc['aesKeyBytes'],
        macBytes: doc['macBytes'],
        aesNonce: doc['aesNonce'],
        cipherText: doc['cipherText']);
  }

  Map<String, dynamic> toMap() {
    return {
      'recordId': recordId,
      'patientId': patientId,
      'name': name,
      'nik': nik,
      'date': date,
      'diseaseHistory': diseaseHistory,
      'diagnosis': diagnosis,
      'recordNumber': recordNumber,
      'location': location,
      'pdfUrl': pdfUrl,
      'publicKey': publicKey,
      'aesKeyBytes': aesKey,
      'macBytes': macBytes,
      'aesNonce': aesNonce,
      'cipherText': cipherText
    };
  }
}
