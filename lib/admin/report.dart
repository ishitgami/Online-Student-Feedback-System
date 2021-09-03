// import 'dart:html';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:osfs1/components/simpleDropdown.dart';
import 'package:osfs1/getData/getFaculty.dart';
import 'package:osfs1/getData/getFeedbackByFaculty.dart';
import 'package:osfs1/getData/getFeedbackQueByFaculty.dart';
import 'package:path_provider/path_provider.dart';
import 'DrawerAdmin.dart';
import 'package:osfs1/constant.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'pdfPreviewScreen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List feedbackList = [];
  final pdf = pw.Document();

  reportPdf() {
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Header(
                level: 0,
               child : pw.Text('FEEDBACK REPORT', style: pw.TextStyle(fontSize: 20,
              ),textScaleFactor: 2),
           ),
            pw.ListView.builder(
                itemCount: feedbackQueByDivisionMap.length,
                itemBuilder: (context, index) {
                  Map ratingmap = Map();
                  ratingmap = feedbackQueByDivisionMap[index]['rating'];
                  var rating = ratingmap.values;
                  var result = rating.reduce((sum, element) => sum + element) /
                      ratingmap.length;
                  result = result.toStringAsFixed(2);
                  return pw.Column(
                    children: [
                      pw.Text(
                        feedbackQueByDivisionMap[index]['question'].toString(),
                        //  style :TextStyle(
                        //    fontSize: 18.0,
                        //  ),
                      ),
                      pw.Row(
                        children: [
                          pw.Expanded(
                            child: pw.Row(
                              children: [
                                pw.Text(
                                  result.toString() == null
                                      ? 'not rate yet'
                                      : result.toString(),
                                  //  style: TextStyle(
                                  //    fontSize: 18.0,
                                  //  ),
                                ),
                                //  pw.Icon(pw.Icons.star),
                              ],
                            ),
                          ),
                          pw.Text(
                            'Total Student = ' + ratingmap.length.toString(),
                            //  style: TextStyle(
                            //    fontSize: 18.0,
                            //  ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
          ];
        }));
  }

  Future savePdf() async {
    if (kIsWeb) {
      // Set web-specific directory
    } else {
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      String documentPath = documentDirectory.path;

      File file = File('$documentPath/report.pdf');
      file.writeAsBytesSync(await pdf.save());
    }
  }

  Future facultyData() async {
    facultyList = [];
    try {
      await GetFacultyData().getfaculty().then((value) => {
            facultyMap = value,
            value.forEach((key, value) {
              setState(() {
                facultyList.add(value);
              });
            })
          });
    } catch (e) {
      print(e);
    }
    return facultyList;
  }

  Future getFeedbackData() async {
    feedbackList = [];
    await FeedbackDataByFaculty(currentFacultyId: currentFacultyId)
        .getFeedbackByFaculty()
        .then((value) => {
              setState(() {
                feedbackList = value;
              })
            });
  }

  Future getFeedbackque() async {
    feedbackQueByDivisionMap = [];
    await GetQuewithRatingForFaculty(
            currentFacultyId: currentFacultyId,
            feedbackId: currentFeedbackValue)
        .getQuewithRatingForFacultyData()
        .then((value) => {
              // setState(() {
              feedbackQueByDivisionMap = value,
              // })
            });
    return feedbackQueByDivisionMap;
  }

  @override
  void initState() {
    super.initState();
    facultyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedbak Report'),
      ),
      drawer: AdminDrawer(),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            simpleDropdown(currentFacultyValue, facultyList, 'choose Faculty',
                (value) {
              setState(() {
                currentFacultyId = facultyMap.keys
                    .firstWhere((element) => facultyMap[element] == value);
                currentFacultyValue = value;
                currentFeedbackValue = null;
                getFeedbackData();
              });
            }),
            simpleDropdown(currentFeedbackValue, feedbackList, 'choose Class',
                (value) {
              setState(() {
                currentFeedbackValue = value;
                getFeedbackque();
              });
            }),
            FutureBuilder(
              future: getFeedbackque(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (snapshot.data.isEmpty) {
                      print('in if');
                      return Container(
                        child: Text('No Rating At this time'),
                      );
                    } else {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              print('ontappp');
                              reportPdf();
                              await savePdf();
                              Directory documentDirectory =
                                  await getApplicationDocumentsDirectory();
                              String documentPath = documentDirectory.path;
                              String fullPath = '$documentPath/report.pdf';
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contex) => PdfPreview(
                                            path: fullPath,
                                          )));
                            },
                            child: Text('Download Report'),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: feedbackQueByDivisionMap.length,
                            itemBuilder: (context, index) {
                              Map ratingmap = Map();
                              ratingmap =
                                  feedbackQueByDivisionMap[index]['rating'];
                              var rating = ratingmap.values;
                              var result = rating
                                      .reduce((sum, element) => sum + element) /
                                  ratingmap.length;
                              result = result.toStringAsFixed(2);
                              return Card(
                                margin: EdgeInsets.all(8),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              feedbackQueByDivisionMap[index]
                                                      ['question']
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        result.toString() ==
                                                                null
                                                            ? 'not rare yet'
                                                            : result.toString(),
                                                        style: TextStyle(
                                                          fontSize: 18.0,
                                                        ),
                                                      ),
                                                      Icon(Icons.star),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  'Total Student = ' +
                                                      ratingmap.length
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }
                  }
                }
                return Container(
                  child: Text('No Feedback Report Available Yet'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
