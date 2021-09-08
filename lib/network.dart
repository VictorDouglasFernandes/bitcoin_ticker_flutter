import 'dart:convert';
import 'package:http/http.dart' as http;

class Network {

  Network(this.url);

  String url;

  Future<dynamic> getData() async {
    http.Response data = await http.get(Uri.parse(this.url));
    return jsonDecode(data.body);
  }
}
