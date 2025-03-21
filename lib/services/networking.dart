// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        String data = response.body;

        return jsonDecode(data);
      } else {
        print('Error: Received status code ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }
}
