import 'api_client.dart';
import '../../models/user.dart';
import '../../models/auth_response.dart';
import '../storage/auth_token_storage.dart';

class AuthApi {
  final ApiClient _client;
  final AuthTokenStorage _tokenStorage;

  AuthApi(this._client, {AuthTokenStorage? tokenStorage})
      : _tokenStorage = tokenStorage ?? AuthTokenStorage();

  /// Login with username/email and password
  /// 
  /// Returns an AuthResponse with user info and tokens.
  /// Automatically stores tokens in secure storage.
  /// 
  /// Throws [ApiException] with:
  /// - statusCode 401: Invalid credentials
  /// - statusCode 0: Network error
  Future<AuthResponse> login(String username, String password) async {
    final data = await _client.post('/auth/login', {
      'username': username,
      'password': password,
    });

    if (data['success'] == true) {
      final authResponse = AuthResponse.fromJson(data);
      
      // Store tokens securely
      await _tokenStorage.saveTokens(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
      );
      
      return authResponse;
    } else {
      throw ApiException(
        data['message'] ?? 'Login failed',
        401,
      );
    }
  }

  /// Refresh the access token using the stored refresh token
  /// 
  /// Returns the new access token string.
  /// Automatically updates the stored access token.
  /// 
  /// Throws [ApiException] with:
  /// - statusCode 401: Invalid or expired refresh token
  /// - statusCode 0: Network error
  Future<String> refreshAccessToken() async {
    final refreshToken = await _tokenStorage.getRefreshToken();
    
    if (refreshToken == null) {
      throw ApiException('No refresh token available', 401);
    }

    final data = await _client.post('/auth/refresh', {
      'refreshToken': refreshToken,
    });

    if (data['success'] == true) {
      final newAccessToken = data['accessToken'] as String;
      
      // Update stored access token
      await _tokenStorage.saveAccessToken(newAccessToken);
      
      return newAccessToken;
    } else {
      throw ApiException(
        data['message'] ?? 'Failed to refresh token',
        401,
      );
    }
  }

  /// Logout by clearing stored tokens
  Future<void> logout() async {
    await _tokenStorage.deleteAllTokens();
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
