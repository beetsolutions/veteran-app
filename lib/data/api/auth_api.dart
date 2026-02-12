import 'api_client.dart';
import '../../models/user.dart';

class AuthApi {
  final ApiClient _client;

  AuthApi(this._client);

  /// Login with username/email and password
  /// 
  /// Returns a User object on success.
  /// 
  /// Throws [ApiException] with:
  /// - statusCode 401: Invalid credentials
  /// - statusCode 0: Network error
  Future<User> login(String username, String password) async {
    final data = await _client.post('/auth/login', {
      'username': username,
      'password': password,
    });

    if (data['success'] == true) {
      return User.fromJson(data['user'] as Map<String, dynamic>);
    } else {
      throw ApiException(
        data['message'] ?? 'Login failed',
        401,
      );
    }
  }

  /// Request password reset for the given email
  /// 
  /// Returns success message string.
  /// 
  /// Throws [ApiException] with:
  /// - statusCode 400: Invalid request (missing email)
  /// - statusCode 0: Network error
  /// 
  /// Note: For security, the endpoint returns success even if the email
  /// doesn't exist to prevent email enumeration attacks.
  Future<String> forgotPassword(String email) async {
    final data = await _client.post('/auth/forgot-password', {
      'email': email,
    });

    if (data['success'] == true) {
      return data['message'] as String;
    } else {
      throw ApiException(
        data['message'] ?? 'Failed to send password reset email',
        400,
      );
    }
  }
}
