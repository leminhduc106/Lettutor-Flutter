import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lettutor_flutter/models/ebook_model/ebook_model.dart';

class EbookService {
  static const String url = "https://sandbox.api.lettutor.com";

  static getListEbookWithPagination(
    int page,
    int size,
    String token, {
    String q = "",
    String categoryId = "",
  }) async {
    String baseUrl = "${EbookService.url}/e-book?page=$page&size=$size";
    if (q.isNotEmpty) {
      baseUrl += "&q=$q";
    }

    if (categoryId.isNotEmpty) {
      baseUrl += "&categoryId[]=$categoryId";
    }

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final ebooks = res["data"]["rows"] as List;
      final arr = ebooks.map((e) => Ebook.fromJson(e)).toList();
      return arr;
    } else {
      throw Exception('Cannot get list course');
    }
  }
}
