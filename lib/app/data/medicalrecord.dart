class MedicalRecord {
  final String patientName;
  final String recordNumber;
  final String visitDate;
  final String anamnesis;
  final String medicalHistory;
  final String diagnosis;

  MedicalRecord(
      {required this.patientName,
      required this.recordNumber,
      required this.visitDate,
      required this.anamnesis,
      required this.medicalHistory,
      required this.diagnosis});
}

final records = [
  MedicalRecord(
      patientName: 'John Doe',
      recordNumber: 'RM001',
      visitDate: '2024-05-27',
      anamnesis: 'Autoanamnesis',
      medicalHistory: 'Asma',
      diagnosis: 'Penyakit Paru-Paru'),
];
