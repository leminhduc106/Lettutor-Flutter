import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:lettutor_flutter/utils/base_style.dart';

class BookDetail extends StatelessWidget {
  const BookDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey[800]),
          title: Text(
            "Book pdf",
            style:
                BaseTextStyle.heading2(color: Colors.grey[800], fontSize: 20),
          ),
        ),
        body: const PDF().cachedFromUrl(
          "http://www.africau.edu/images/default/sample.pdf",
          placeholder: (progress) => Center(child: Text('$progress %')),
          errorWidget: (error) => Center(child: Text(error.toString())),
        ),
      ),
    );
  }
}
