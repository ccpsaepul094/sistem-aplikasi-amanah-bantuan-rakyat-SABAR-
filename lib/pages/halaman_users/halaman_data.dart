import 'package:flutter/material.dart';

class DataKambingPage extends StatelessWidget {
  final List<Map<String, dynamic>> dataKambing = [
    {
      'nama': 'Kambing A',
      'umur': '1 Tahun',
      'berat': '25 kg',
      'status': 'Sehat'
    },
    {
      'nama': 'Kambing B',
      'umur': '8 Bulan',
      'berat': '20 kg',
      'status': 'Sehat'
    },
    {
      'nama': 'Kambing C',
      'umur': '1,5 Tahun',
      'berat': '30 kg',
      'status': 'Sakit'
    },
    {
      'nama': 'Kambing D',
      'umur': '6 Bulan',
      'berat': '18 kg',
      'status': 'Sehat'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Data Kambing",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: dataKambing.length,
                  itemBuilder: (context, index) {
                    final kambing = dataKambing[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      margin: EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 24,
                          backgroundColor: kambing['status'] == 'Sehat'
                              ? Colors.green[100]
                              : Colors.red[100],
                          child: Icon(
                            Icons.pets,
                            color: kambing['status'] == 'Sehat'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        title: Text(
                          kambing['nama'],
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          "Umur: ${kambing['umur']}\nBerat: ${kambing['berat']}\nStatus: ${kambing['status']}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                        isThreeLine: true,
                        trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16),
                        onTap: () {
                          // TODO: Tambahkan aksi jika ingin menampilkan detail kambing
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
