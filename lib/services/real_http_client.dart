import 'package:http/http.dart' as http;

import 'http_client.dart';

class RealHttpClient implements HttpClient {
  const RealHttpClient();

  @override
  Future<String> get(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) return response.body;
    return '';
  }
}
