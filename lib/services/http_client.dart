import 'dart:async';

abstract class HttpClient {
  Future<String> get(String url);
}
