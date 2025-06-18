import 'package:flutter/material.dart';
import 'package:sabar_/utils/eksport_datakambing.dart';
import 'package:sabar_/pages/halaman_users/halaman_edit.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class DataKambingPage extends StatefulWidget {
  @override
  _DataKambingPageState createState() => _DataKambingPageState();
}

class _DataKambingPageState extends State<DataKambingPage> {
  final List<Map<String, dynamic>> dataKambing = [
    {
      'nama': '001',
      'umur': '01 Jan 2024',
      'berat': '25 kg',
      'status': 'hidup',
      'foto': '', // bisa diganti path lokal jika tersedia
      'keterangan': 'Induk A'
    },
    {
      'nama': '002',
      'umur': '10 Feb 2024',
      'berat': '20 kg',
      'status': 'hidup',
      'foto': '',
      'keterangan': 'Anak dari Induk B'
    },
  ];

  File? selectedImage;
  final ImagePicker picker = ImagePicker();

  String _namaBulan(int bulan) {
    const bulanList = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "Mei",
      "Juni",
      "Juli",
      "Agus",
      "Sep",
      "Okt",
      "Nov",
      "Des"
    ];
    return bulanList[bulan - 1];
  }

  void hapusTernak(String id) {
    setState(() {
      dataKambing.removeWhere((ternak) => ternak['nama'] == id);
    });
  }

  final List<Map<String, dynamic>> dataKelahiran = [
    {
      'nama': '002',
      'umur': '10 Feb 2024',
      'berat': '20 kg',
      'status': 'hidup',
      'foto': '',
      'keterangan': 'Anak dari Induk B'
    },
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
  void _showAddKambingDialog() {
    String tanggalLahir = '';
    String berat = '';
    String status = 'hidup';
    String keterangan = '';
    TextEditingController tanggalLahirController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        final newId = (dataKambing.length + 1).toString().padLeft(3, '0');
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
              width: MediaQuery.of(context).size.width * 0.95,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🔹 ID & Tanggal Lahir
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: newId,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'ID',
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: tanggalLahirController,
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              String formattedDate =
                                  "${pickedDate.day.toString().padLeft(2, '0')} ${_namaBulan(pickedDate.month)} ${pickedDate.year}";
                              setState(() {
                                tanggalLahir = formattedDate;
                                tanggalLahirController.text = formattedDate;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Tanggal Lahir',
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // 🔹 Berat & Status
                  Row(
                    children: [
                      Expanded(
                        child: _buildInputField(
                          label: 'Berat',
                          onChanged: (val) => berat = val,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          dropdownColor: Colors.blue.shade800,
                          value: status,
                          decoration: InputDecoration(
                            labelText: 'Status',
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
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
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // 🔹 Foto Kambing
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Foto Kambing",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () async {
                          final pickedFile = await picker.pickImage(
                              source: ImageSource.gallery);

                          if (pickedFile != null) {
                            setState(() {
                              selectedImage = File(pickedFile.path);
                            });
                          }
                        },
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white10,
                          ),
                          child: selectedImage == null
                              ? Center(
                                  child: Text(
                                    "Pilih Foto",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.white),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(selectedImage!,
                                      fit: BoxFit.cover),
                                ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // 🔹 Keterangan diperbesar
                  TextField(
                    onChanged: (val) => keterangan = val,
                    maxLines: 3,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Keterangan',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
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
                if (tanggalLahir.isNotEmpty && berat.isNotEmpty) {
                  setState(() {
                    dataKambing.add({
                      'nama': newId,
                      'umur': tanggalLahir,
                      'berat': berat,
                      'status': status,
                      'foto': selectedImage?.path ?? '',
                      'keterangan': keterangan,
                    });
                  });

                  dataKelahiran.add({
                    'nama': newId,
                    'umur': tanggalLahirController.text, // <== ini penting!
                    'berat': berat,
                    'status': status,
                    'foto': selectedImage?.path ?? '',
                    'induk': keterangan, // anggap ini berisi nama induk
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
                                backgroundImage: kambing['foto'] != null &&
                                        kambing['foto'] != ''
                                    ? FileImage(File(kambing['foto']))
                                    : AssetImage('images/domba.jpeg')
                                        as ImageProvider,
                              ),
                              title: Text(
                                kambing['nama'],
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                "Berat: ${kambing['berat']}\nStatus: ${kambing['status']}",
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
                          child: InkWell(
                            onTap: () => _showDetailTernak(context, anak),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    anak['foto'] != null && anak['foto'] != ''
                                        ? FileImage(File(anak['foto']))
                                        : AssetImage('images/domba.jpeg')
                                            as ImageProvider,
                              ),
                              title: Text(
                                anak['nama'],
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                "Umur: ${anak['umur']}\nBerat: ${anak['berat']}\nStatus: ${anak['status']}",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                              isThreeLine: true,
                            ),
                          ));
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
