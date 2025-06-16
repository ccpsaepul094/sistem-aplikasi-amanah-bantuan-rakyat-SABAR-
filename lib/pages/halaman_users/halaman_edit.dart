import 'package:flutter/material.dart';

class EditTernakPage extends StatefulWidget {
  final Map<String, dynamic> kambing;

  EditTernakPage({required this.kambing});

  @override
  _EditTernakPageState createState() => _EditTernakPageState();
}

class _EditTernakPageState extends State<EditTernakPage> {
  late TextEditingController namaController;
  late TextEditingController umurController;
  late TextEditingController beratController;
  late TextEditingController statusController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.kambing['nama']);
    umurController = TextEditingController(text: widget.kambing['umur']);
    beratController = TextEditingController(text: widget.kambing['berat']);
    statusController = TextEditingController(text: widget.kambing['status']);
  }

  @override
  void dispose() {
    namaController.dispose();
    umurController.dispose();
    beratController.dispose();
    statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Ternak")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: umurController,
              decoration: InputDecoration(labelText: "Umur"),
            ),
            TextField(
              controller: beratController,
              decoration: InputDecoration(labelText: "Berat"),
            ),
            TextField(
              controller: statusController,
              decoration: InputDecoration(labelText: "Status"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedKambing = {
                  'nama': namaController.text,
                  'umur': umurController.text,
                  'berat': beratController.text,
                  'status': statusController.text,
                };
                Navigator.pop(context, updatedKambing);
              },
              child: Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}

