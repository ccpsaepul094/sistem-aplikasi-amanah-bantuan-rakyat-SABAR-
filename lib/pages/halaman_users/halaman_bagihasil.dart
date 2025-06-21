import 'package:flutter/material.dart';
import 'package:sabar_/utils/generatePDF.dart';
import 'package:sabar_/utils/data_globals.dart';

class BagihasilPage extends StatefulWidget {
  final Map<String, dynamic>? newKambing;
  BagihasilPage({this.newKambing});

  @override
  _BagihasilPageState createState() => _BagihasilPageState();
}

class _BagihasilPageState extends State<BagihasilPage> {
  @override
  void initState() {
    super.initState();

    if (widget.newKambing != null) {
      final newData = {
        'id_bagihasil': DateTime.now().millisecondsSinceEpoch.toString(),
        'nama': widget.newKambing!['nama'],
        'nama_peternak': widget.newKambing!['nama_peternak'],
        'tanggal': _formatTanggal(DateTime.now()),
        'harga': widget.newKambing!['harga'],
        'status': false,
        'metode_pembayaran': null,
      };

      // Buat salinan list dan tambahkan data baru
      final updatedList = [...dataBagihasil.value, newData];

      // Update value agar UI otomatis rebuild
      dataBagihasil.value = updatedList;
    }
  }

  String _formatTanggal(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')} ${_bulan(date.month)} ${date.year}";
  }

  String _bulan(int bulan) {
    const namaBulan = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return namaBulan[bulan];
  }

  void _showFormPembayaran(BuildContext context, int index) {
    String metode = 'Transfer Bank';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Pembayaran', style: TextStyle(fontFamily: 'Poppins')),
          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: metode,
                    decoration: InputDecoration(
                      labelText: 'Metode Pembayaran',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                          value: 'Transfer Bank', child: Text('Transfer Bank')),
                      DropdownMenuItem(value: 'Tunai', child: Text('Tunai')),
                    ],
                    onChanged: (value) {
                      setStateDialog(() {
                        metode = value!;
                      });
                    },
                  ),

                  // 🔽 Tambahkan bagian ini agar tampil rekening virtual
                  if (metode == 'Transfer Bank') ...[
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Transfer ke rekening berikut:",
                              style: TextStyle(fontFamily: 'Poppins')),
                          SizedBox(height: 4),
                          Text("Bank BRI - 1234 5678 9012",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins')),
                          Text("A.N. Koperasi Ternak Sejahtera"),
                        ],
                      ),
                    ),
                  ]
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Batal", style: TextStyle(fontFamily: 'Poppins')),
            ),
            ElevatedButton(
              onPressed: () {
                final list = [...dataBagihasil.value];
                list[index]['status'] = true;
                list[index]['metode_pembayaran'] = metode;
                dataBagihasil.value = list;
                Navigator.pop(context);
              },
              child: Text("Bayar"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
          ],
        );
      },
    );
  }

  void _showDetailTransaksi(
      BuildContext context, Map<String, dynamic> kambing) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Center(
            child: Text("Detail Transaksi",
                style: TextStyle(
                    fontFamily: "Poppins", fontWeight: FontWeight.bold)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRow("ID Transaksi", kambing['id_bagihasil'] ?? "-"),
              _buildRow("Tanggal", kambing['tanggal'] ?? "-"),
              _buildRow("Nama Kambing", kambing['nama'] ?? "-"),
              _buildRow("Harga Tebus", "Rp ${kambing['harga'] ?? 0}"),
              _buildRow("Status", kambing['status'] ? "Lunas" : "Belum Lunas",
                  color: kambing['status'] ? Colors.green : Colors.orange),
              _buildRow(
                  "Metode Pembayaran", kambing['metode_pembayaran'] ?? "-"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Tutup", style: TextStyle(fontFamily: "Poppins")),
            ),
            ElevatedButton(
              onPressed: () => generatePDF(kambing),
              child: Text("Export PDF"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
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
            child: Text(label,
                style:
                    TextStyle(fontFamily: "Poppins", color: Colors.grey[700])),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Data Bagi Hasil",
          style: TextStyle(fontFamily: "Poppins", color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder<List<Map<String, dynamic>>>(
                valueListenable: dataBagihasil,
                builder: (context, list, _) {
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final kambing = list[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        margin: EdgeInsets.only(bottom: 12),
                        elevation: 2,
                        child: InkWell(
                          onTap: () => _showDetailTransaksi(context, kambing),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.green.withOpacity(0.2),
                              child: Icon(Icons.pets, color: Colors.green),
                            ),
                            title: Text(
                              'ID : ${kambing["id_bagihasil"]}',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tanggal: ${kambing["tanggal"]}",
                                  style: TextStyle(fontFamily: "Poppins"),
                                ),
                                Text(
                                  "Tagihan: Rp ${kambing["harga"]}",
                                  style: TextStyle(fontFamily: "Poppins"),
                                ),
                                if (kambing["metode_pembayaran"] != null)
                                  Text(
                                    "Metode: ${kambing["metode_pembayaran"]}",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                              ],
                            ),
                            trailing: kambing["status"]
                                ? Chip(
                                    label: Text(
                                      "Lunas",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Colors.white),
                                    ),
                                    backgroundColor: Colors.green,
                                  )
                                : ElevatedButton(
                                    onPressed: () =>
                                        _showFormPembayaran(context, index),
                                    child: Text("Bayar"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
