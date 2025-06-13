import 'package:flutter/material.dart';
import 'package:sabar_/utils/generatePDF.dart';

class BagihasilPage extends StatefulWidget {
  @override
  _BagihasilPageState createState() => _BagihasilPageState();
}

class _BagihasilPageState extends State<BagihasilPage> {
  List<Map<String, dynamic>> dataKambing = [
    {
      "id_bagihasil": "001345",
      "nama": "Kambing Jantan 01",
      "nama_peternak": "Acep Mujahid",
      "tanggal": "7 Mei 2025",
      "harga": 2000000,
      "status": false,
      "metode_pembayaran": null,
    },
  ];

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
                setState(() {
                  dataKambing[index]['status'] = true;
                  dataKambing[index]['metode_pembayaran'] = metode;
                });
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
            child: Text(
              "Detail Transaksi",
              style:
                  TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),
            ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Data Bagi Hasil", style: TextStyle(fontFamily: "Poppins")),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: dataKambing.length,
                itemBuilder: (context, index) {
                  final kambing = dataKambing[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
                          'ID : ${kambing["id_bagihasil"] ?? "-"}',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tanggal: ${kambing["tanggal"] ?? "-"}",
                              style: TextStyle(fontFamily: "Poppins"),
                            ),
                            Text(
                              "Tagihan: Rp ${kambing["harga"] ?? 0}",
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
                                    color: Colors.white,
                                  ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
