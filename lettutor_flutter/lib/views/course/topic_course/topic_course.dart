import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CourseTopicPDFViewer extends StatefulWidget {
  const CourseTopicPDFViewer({Key? key, required this.url, required this.title})
      : super(key: key);
  final String url;
  final String title;

  @override
  State<CourseTopicPDFViewer> createState() => _CourseTopicPDFViewerState();
}

class _CourseTopicPDFViewerState extends State<CourseTopicPDFViewer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leadingWidth: 20,
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey[800]),
          title: Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              widget.title,
              style: TextStyle(color: Colors.grey[800]),
            ),
          ),
        ),
        body: Center(
          child: SfPdfViewer.network(
            widget.url,
            canShowScrollHead: false,
            canShowScrollStatus: false,
          ),
        ),
      ),
    );
  }
}
