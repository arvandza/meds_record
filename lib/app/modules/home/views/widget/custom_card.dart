import 'package:flutter/material.dart';
import '../../../../data/models/medicalrecord_model.dart';

class CustomCard {
  static Widget buildPersonalDetails(MedicalrecordModel record) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage('assets/images/user_placeholder.jpg'),
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      record.name!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildMedicalHistory(MedicalrecordModel record) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Riwayat Pemeriksaan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildDetailRow('No.Rekam Medis', record.recordNumber!),
            const Divider(
              color: Colors.black12,
              thickness: 0.1,
            ),
            _buildDetailRow('Tanggal Pemeriksaan',
                '${record.date!.day}-${record.date!.month}-${record.date!.year}'),
            const Divider(
              color: Colors.black12,
              thickness: 0.1,
            ),
            _buildDetailRow('Riwayat Penyakit', record.diseaseHistory!),
            const Divider(
              color: Colors.black12,
              thickness: 0.1,
            ),
            _buildDetailRow('Diagnosis', record.diagnosis!),
            const Divider(
              color: Colors.black12,
              thickness: 0.1,
            ),
            _buildDetailRow('Lokasi', record.location!),
          ],
        ),
      ),
    );
  }

  static Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
