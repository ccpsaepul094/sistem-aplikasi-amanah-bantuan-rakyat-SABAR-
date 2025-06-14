import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

Future<void> exportAllKambingToPdf(List<Map<String, dynamic>> data) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Data Kambing',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 16),
            pw.Table.fromTextArray(
              headers: ['Nama', 'Umur', 'Berat', 'Status'],
              data: data
                  .map((item) => [
                        item['nama'] ?? '',
                        item['umur'] ?? '',
                        item['berat'] ?? '',
                        item['status'] ?? '',
                      ])
                  .toList(),
              border: pw.TableBorder.all(),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
              cellAlignment: pw.Alignment.centerLeft,
              cellPadding: pw.EdgeInsets.all(8),
            ),
          ],
        );
      },
    ),
  );

  // Simpan PDF ke file
  final output = await getTemporaryDirectory();
  final file = File("${output.path}/data_kambing.pdf");
  await file.writeAsBytes(await pdf.save());

  // Buka file PDF
  await OpenFile.open(file.path);
}
