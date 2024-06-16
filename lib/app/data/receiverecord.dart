import 'medicalrecord.dart';

class Receiverecord {
  final MedicalRecord? medRecord;

  Receiverecord({this.medRecord});
}

List<Receiverecord> receiveRecord = [
  Receiverecord(medRecord: records[0]),
];
