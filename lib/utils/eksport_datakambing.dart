import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

String formatTanggal(DateTime date) {
  const namaBulan = [
    '', // index 0 kosong karena bulan dimulai dari 1
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
    'Desember',
  ];

  return "${date.day.toString().padLeft(2, '0')} ${namaBulan[date.month]} ${date.year}";
}

Future<void> exportAllKambingToPdf(List<Map<String, dynamic>> data) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'LAPORAN DATA TERNAK KAMBING',
              style: pw.TextStyle(
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
                decoration: pw.TextDecoration.underline,
              ),
            ),
            pw.SizedBox(height: 12),
            pw.Text(
                "Data direkap pada tanggal ${formatTanggal(DateTime.now())}"),
            pw.Text("Nama peternak : Acep Mujahid"),
            pw.Text("Id ternak : 23030303"),
            pw.Text("Jumlah ternak : ${data.length}"),
            pw.SizedBox(height: 12),
            pw.Text(
                "Jumlah hidup : ${data.where((e) => e['status'] == 'hidup').length}"),
            pw.Text(
                "Jumlah mati : ${data.where((e) => e['status'] == 'mati').length}"),
            pw.SizedBox(height: 20),
            pw.Text('Daftar Ternak',
                style:
                    pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
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
