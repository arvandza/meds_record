import 'package:meds_record/app/data/medicalrecord.dart';

class ListRecord {
  final String requestName;
  final String instansi;
  final String keperluan;
  final MedicalRecord? medicalRecord;

  ListRecord(
      {required this.requestName,
      required this.instansi,
      required this.keperluan,
      this.medicalRecord});
}

List<ListRecord> listRecord = [
  ListRecord(
      requestName: 'Herman',
      instansi: 'Dinas Kesehatan',
      keperluan: 'Pengobatan',
      medicalRecord: records[0]),
  ListRecord(
      requestName: 'Tutik',
      instansi: 'Rumah Sakit Umum',
      keperluan: 'Research',
      medicalRecord: records[0]),
];
