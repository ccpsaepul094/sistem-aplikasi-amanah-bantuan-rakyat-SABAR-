import 'package:flutter/material.dart';

class BagihasilPage extends StatefulWidget {
  @override
  _BagihasilPageState createState() => _BagihasilPageState();
}

class _BagihasilPageState extends State<BagihasilPage> {
  List<Map<String, dynamic>> dataKambing = [
    {
      "nama": "Kambing Jantan 01",
      "harga": 2000000,
      "status": false,
      "metode_pembayaran": null,
    },
    {
      "nama": "Kambing Betina 02",
      "harga": 1750000,
      "status": true,
      "metode_pembayaran": "Transfer Bank",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Daftar Anak Kambing",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
              ),
            ),
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
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green.withOpacity(0.2),
                        child: Icon(Icons.pets, color: Colors.green),
                      ),
                      title: Text(
                        kambing["nama"],
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Harga Tebus: Rp ${kambing["harga"]}",
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
