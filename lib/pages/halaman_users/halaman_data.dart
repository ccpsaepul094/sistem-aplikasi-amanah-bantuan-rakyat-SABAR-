import 'package:flutter/material.dart';
import 'package:sabar_/utils/eksport_datakambing.dart';
import 'package:sabar_/pages/halaman_users/halaman_edit.dart';

class DataKambingPage extends StatefulWidget {
  @override
  _DataKambingPageState createState() => _DataKambingPageState();
}

class _DataKambingPageState extends State<DataKambingPage> {
  final List<Map<String, dynamic>> dataKambing = [
    {'nama': '001', 'umur': '1 Tahun', 'berat': '25 kg', 'status': 'hidup'},
    {'nama': '002', 'umur': '8 Bulan', 'berat': '20 kg', 'status': 'hidup'},
  ];

  void hapusTernak(String id) {
    setState(() {
      dataKambing.removeWhere((ternak) => ternak['nama'] == id);
    });
  }

  final List<Map<String, dynamic>> dataKelahiran = [
    {'nama': '003', 'tanggal': '01 Jan 2025', 'induk': 'Kambing A'},
    {'nama': '004', 'tanggal': '10 Feb 2025', 'induk': 'Kambing B'},
  ];

  final List<Map<String, dynamic>> dataKematian = [
    {'nama': 'Kambing Z', 'tanggal': '05 Mar 2025', 'penyebab': 'Penyakit'},
  ];

  void _showDetailTernak(BuildContext context, Map<String, dynamic> kambing) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Center(
            child: Text(
              "Detail Ternak",
              style:
                  TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipOval(
                  child: Image.asset(
                    'images/domba.jpeg',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _buildRow("id ternak", kambing['nama'] ?? "-"),
              _buildRow("umur ", kambing['umur'] ?? "-"),
              _buildRow("berat", kambing['berat'] ?? "-"),
              _buildRow("status", kambing['status'] ?? "-"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Tutup", style: TextStyle(fontFamily: "Poppins")),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // tutup dialog dulu
                final updatedKambing = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTernakPage(
                      kambing: kambing,
                    ),
                  ),
                );

                if (updatedKambing != null) {
                  setState(() {
                    final index = dataKambing.indexOf(kambing);
                    dataKambing[index] = updatedKambing;
                  });
                }
              },
              child: Text("edit", style: TextStyle(fontFamily: "Poppins")),
            ),
            TextButton(
              onPressed: () {
                hapusTernak(kambing['nama']); // panggil fungsi hapus
                Navigator.pop(context); // tutup dialog
              },
              child: Text("hapus", style: TextStyle(fontFamily: "Poppins")),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: TextStyle(fontFamily: "Poppins", color: Colors.grey[700]),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                color: color ?? Colors.black,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  int selectedIndex = 0;

  //tambah data kambing
  void _showAddKambingDialog() {
    String nama = '';
    String umur = '';
    String berat = '';
    String status = 'hidup';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue.shade700,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            "Tambah Data Kambing",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width *
                  0.8, // Lebar 80% dari layar
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildInputField(
                    label: 'id',
                    onChanged: (val) => nama = val,
                  ),
                  SizedBox(height: 10),
                  _buildInputField(
                    label: 'tanggal lahir',
                    onChanged: (val) => umur = val,
                  ),
                  SizedBox(height: 10),
                  _buildInputField(
                    label: 'Berat',
                    onChanged: (val) => berat = val,
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    dropdownColor: Colors.blue.shade800,
                    value: status,
                    decoration: InputDecoration(
                      labelText: 'Status',
                      labelStyle:
                          TextStyle(color: Colors.white, fontFamily: "Poppins"),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    style:
                        TextStyle(color: Colors.white, fontFamily: "Poppins"),
                    iconEnabledColor: Colors.white,
                    items: ['hidup', 'mati']
                        .map((s) => DropdownMenuItem(
                              value: s,
                              child: Text(s,
                                  style: TextStyle(color: Colors.white)),
                            ))
                        .toList(),
                    onChanged: (val) => status = val ?? 'hidup',
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Batal", style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
              ),
              onPressed: () {
                if (nama.isNotEmpty && umur.isNotEmpty && berat.isNotEmpty) {
                  setState(() {
                    dataKambing.add({
                      'nama': nama,
                      'umur': umur,
                      'berat': berat,
                      'status': status,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: Text("Simpan", style: TextStyle(fontFamily: "Poppins")),
            ),
          ],
        );
      },
    );
  }

  //tambah kelahiran

  //tambah kemtian
  void _showAddKematian() {
    String nama = '';
    String umur = '';
    String berat = '';
    String status = 'hidup';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue.shade700,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            "Tambah Data Kambing",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width *
                  0.8, // Lebar 80% dari layar
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildInputField(
                    label: 'Nama',
                    onChanged: (val) => nama = val,
                  ),
                  SizedBox(height: 10),
                  _buildInputField(
                    label: 'Umur',
                    onChanged: (val) => umur = val,
                  ),
                  SizedBox(height: 10),
                  _buildInputField(
                    label: 'Berat',
                    onChanged: (val) => berat = val,
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    dropdownColor: Colors.blue.shade800,
                    value: status,
                    decoration: InputDecoration(
                      labelText: 'Status',
                      labelStyle:
                          TextStyle(color: Colors.white, fontFamily: "Poppins"),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    style:
                        TextStyle(color: Colors.white, fontFamily: "Poppins"),
                    iconEnabledColor: Colors.white,
                    items: ['hidup', 'mati']
                        .map((s) => DropdownMenuItem(
                              value: s,
                              child: Text(s,
                                  style: TextStyle(color: Colors.white)),
                            ))
                        .toList(),
                    onChanged: (val) => status = val ?? 'hidup',
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Batal", style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
              ),
              onPressed: () {
                if (nama.isNotEmpty && umur.isNotEmpty && berat.isNotEmpty) {
                  setState(() {
                    dataKambing.add({
                      'nama': nama,
                      'umur': umur,
                      'berat': berat,
                      'status': status,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: Text("Simpan", style: TextStyle(fontFamily: "Poppins")),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInputField(
      {required String label, required Function(String) onChanged}) {
    return TextField(
      onChanged: onChanged,
      style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white, fontFamily: "Poppins"),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

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
              _showAddKambingDialog();
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
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Tombol Ekspor PDF (di atas)
          FloatingActionButton(
            heroTag: 'export',
            onPressed: () {
              exportAllKambingToPdf(
                  dataKambing); // Panggil fungsi ekspor PDF kamu
            },
            backgroundColor: Colors.redAccent,
            tooltip: 'Ekspor PDF',
            child: Icon(Icons.picture_as_pdf),
          ),
          SizedBox(height: 12), // Spasi antar tombol
          // Tombol Tambah Data
          FloatingActionButton(
            heroTag: 'add',
            onPressed: _showAddOptions,
            backgroundColor: Colors.blue,
            tooltip: 'Tambah Data',
            child: Icon(Icons.add),
          ),
        ],
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
                          child: InkWell(
                            onTap: () => _showDetailTernak(context, kambing),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    AssetImage('images/domba.jpeg'),
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
                          ));
                    } else if (selectedIndex == 1) {
                      final anak = dataKelahiran[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        margin: EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('images/domba.jpeg'),
                          ),
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
