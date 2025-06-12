import 'package:flutter/material.dart';

class DataKambingPage extends StatefulWidget {
  @override
  _DataKambingPageState createState() => _DataKambingPageState();
}

class _DataKambingPageState extends State<DataKambingPage> {
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

  final List<Map<String, dynamic>> dataKelahiran = [
    {'nama': 'Anak A', 'tanggal': '01 Jan 2025', 'induk': 'Kambing A'},
    {'nama': 'Anak B', 'tanggal': '10 Feb 2025', 'induk': 'Kambing B'},
  ];

  final List<Map<String, dynamic>> dataKematian = [
    {'nama': 'Kambing Z', 'tanggal': '05 Mar 2025', 'penyebab': 'Penyakit'},
  ];

  int selectedIndex = 0;

  void _showAddOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.pets),
            title: Text('Tambah Data Kambing'),
            onTap: () {
              Navigator.pop(context);
              // Navigasi atau aksi tambah kambing
            },
          ),
          ListTile(
            leading: Icon(Icons.cake),
            title: Text('Tambah Data Kelahiran'),
            onTap: () {
              Navigator.pop(context);
              // Navigasi atau aksi tambah kelahiran
            },
          ),
          ListTile(
            leading: Icon(Icons.sentiment_dissatisfied),
            title: Text('Tambah Data Kematian'),
            onTap: () {
              Navigator.pop(context);
              // Navigasi atau aksi tambah kematian
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddOptions,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "Data Ternak",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2, top: 12, right: 2),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari Data Ternak',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedIndex = 0),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: selectedIndex == 0
                                ? Colors.white
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'Data Kambing',
                              style: TextStyle(
                                color: selectedIndex == 0
                                    ? Colors.blue.shade900
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedIndex = 1),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: selectedIndex == 1
                                ? Colors.white
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'Kelahiran',
                              style: TextStyle(
                                color: selectedIndex == 1
                                    ? Colors.blue.shade900
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedIndex = 2),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: selectedIndex == 2
                                ? Colors.white
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'Kematian',
                              style: TextStyle(
                                color: selectedIndex == 2
                                    ? Colors.blue.shade900
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: selectedIndex == 0
                      ? dataKambing.length
                      : selectedIndex == 1
                          ? dataKelahiran.length
                          : dataKematian.length,
                  itemBuilder: (context, index) {
                    if (selectedIndex == 0) {
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
                        ),
                      );
                    } else if (selectedIndex == 1) {
                      final anak = dataKelahiran[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        margin: EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: Icon(Icons.cake, color: Colors.green),
                          title: Text(
                            anak['nama'],
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            "Tanggal Lahir: ${anak['tanggal']}\nInduk: ${anak['induk']}",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                          isThreeLine: true,
                        ),
                      );
                    } else {
                      final kematian = dataKematian[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        margin: EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: Icon(Icons.sentiment_dissatisfied,
                              color: Colors.red),
                          title: Text(
                            kematian['nama'],
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            "Tanggal: ${kematian['tanggal']}\nPenyebab: ${kematian['penyebab']}",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                          isThreeLine: true,
                        ),
                      );
                    }
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
