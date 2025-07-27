// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(
      {required this.url, required this.api, required this.errorMessage});

  final String url;
  final String api;
  final String errorMessage;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        String data = response.body;

        return jsonDecode(data);
      } else {
        print('Error: Received status code ${response.statusCode} for $api');
        return null;
      }
    } catch (e) {
      print('$errorMessage: $e');
      return null;
    }
  }
}
