import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:workproject/screens/2_classcheck/course/models/student_model.dart';

Future<void> createAndDisplayPdf(
    BuildContext context, List<StudentModel> students, String courseName, DateTime createdAt, String createdBy) async {
  final pdf = pw.Document();
  // final theme = pw.ThemeData.withFont(
  //   base: pw.Font.ttf(await rootBundle.load("assets/fonts/OpenSans-Regular.ttf")),
  //   bold: pw.Font.ttf(await rootBundle.load("assets/fonts/OpenSans-Bold.ttf")),
  // );

  final String formattedCreatedAt = DateFormat('dd MMM yyyy-kk:mm').format(createdAt);

  pdf.addPage(
    pw.Page(
      // theme: theme,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Course Name: $courseName", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text("Created by $createdBy, On $formattedCreatedAt",
                style: pw.TextStyle(
                  fontSize: 12,
                )),
            pw.SizedBox(height: 20),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: PdfColors.grey300),
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Text('Student ID', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Text('Student Name', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Text('Time Stamp', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                  ],
                ),
                ...students.map(
                  (student) => pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text(student.studentID),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text(student.studentName),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text(
                            "${student.checkedInAt.hour}:${student.checkedInAt.minute}:${student.checkedInAt.second}"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            pw.Spacer(),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                'Generated on: ${DateTime.now().toString()}',
                style: pw.TextStyle(fontSize: 10, fontStyle: pw.FontStyle.italic),
              ),
            ),
          ],
        );
      },
    ),
  );

  final pdfFile = await saveDocument(name: '${courseName.replaceAll(" ", "_")}_Students.pdf', pdf: pdf);
  showPdf(context, pdfFile);
}

// ฟังก์ชันสำหรับบันทึก PDF ลงในไฟล์
Future<File> saveDocument({required String name, required pw.Document pdf}) async {
  final bytes = await pdf.save();
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/$name');

  await file.writeAsBytes(bytes);
  return file;
}

// ฟังก์ชันสำหรับแสดง PDF
void showPdf(BuildContext context, File pdfFile) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => PdfPreviewScreen(pdfFile: pdfFile),
    ),
  );
}

// สร้างหน้าจอสำหรับแสดง PDF
class PdfPreviewScreen extends StatelessWidget {
  final File pdfFile;

  const PdfPreviewScreen({Key? key, required this.pdfFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (format) => pdfFile.readAsBytesSync(),
      ),
    );
  }
}
