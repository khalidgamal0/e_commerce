import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  //get request methods
  Future<dynamic> get(
      {required String url,
      required String? token,
      String lang = 'en',
      Map<String, dynamic>? query}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    return jsonDecode(response.body);
  }

  //Post request methods
  Future<dynamic> post({
    required String url,
    required dynamic body,
    String? token,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'lang': 'en',
      'Authorization': token ?? ''
    };
    http.Response response =
        await http.post(Uri.parse(url), body: body, headers: headers);
    Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  }

//Put request methods
  Future<dynamic> put({
    required String url,
    required dynamic body,
    String? token,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'lang': 'en',
      'Authorization': token ?? ''
    };
    http.Response response = await http.put(
      Uri.parse(url),
      body: body,
      headers: headers,
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  }
}
