import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> generatePDF(Map<String, dynamic> kambing) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Detail Transaksi', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 16),
            _pdfRow("ID Transaksi", kambing['id_bagihasil'] ?? "-"),
            _pdfRow("Tanggal", kambing['tanggal'] ?? "-"),
            _pdfRow("Nama Kambing", kambing['nama'] ?? "-"),
            _pdfRow("Harga Tebus", "Rp ${kambing['harga'] ?? 0}"),
            _pdfRow("Status", kambing['status'] ? "Lunas" : "Belum Lunas"),
            _pdfRow("Metode Pembayaran", kambing['metode_pembayaran'] ?? "-"),
          ],
        );
      },
    ),
  );

  await Printing.layoutPdf(onLayout: (format) async => pdf.save());
}

pw.Widget _pdfRow(String label, String value) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 4),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(label, style: pw.TextStyle(fontSize: 12)),
        pw.Text(value, style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
      ],
    ),
  );
}


