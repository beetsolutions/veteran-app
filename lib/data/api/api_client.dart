import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final http.Client? httpClient;

  ApiClient({
    this.baseUrl = 'http://192.168.1.200:3000',
    http.Client? client,
  }) : httpClient = client ?? http.Client();

  /// Make a GET request to the API
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await httpClient!.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ApiException(
          'Failed to load data: ${response.statusCode}',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: $e', 0);
    }
  }

  /// Make a POST request to the API
  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await httpClient!.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw ApiException(
          'Failed to post data: ${response.statusCode}',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: $e', 0);
    }
  }

  void dispose() {
    httpClient?.close();
  }
}

class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, this.statusCode);

  @override
  String toString() => message;
}
