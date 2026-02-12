import 'dart:convert';
import 'package:http/http.dart' as http;
import '../storage/auth_token_storage.dart';

class ApiClient {
  final String baseUrl;
  final http.Client? httpClient;
  final AuthTokenStorage _tokenStorage;

  ApiClient({
    this.baseUrl = 'http://192.168.1.200:3000',
    http.Client? client,
    AuthTokenStorage? tokenStorage,
  })  : httpClient = client ?? http.Client(),
        _tokenStorage = tokenStorage ?? AuthTokenStorage();

  /// Get authorization headers with access token if available
  Future<Map<String, String>> _getHeaders() async {
    final headers = {'Content-Type': 'application/json'};
    
    final accessToken = await _tokenStorage.getAccessToken();
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    
    return headers;
  }

  /// Make a GET request to the API
  Future<dynamic> get(String endpoint) async {
    try {
      final headers = await _getHeaders();
      final response = await httpClient!.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
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
      final headers = await _getHeaders();
      final response = await httpClient!.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
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
