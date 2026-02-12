import '../storage/auth_token_storage.dart';
import 'dart:convert';

/// Service for managing authentication state and token validation
class AuthService {
  final AuthTokenStorage _tokenStorage;

  AuthService({AuthTokenStorage? tokenStorage})
      : _tokenStorage = tokenStorage ?? AuthTokenStorage();

  /// Check if user is currently authenticated with a valid token
  /// 
  /// Returns true if:
  /// - Access token exists in storage
  /// - Token is not expired (has valid exp claim)
  Future<bool> isAuthenticated() async {
    final accessToken = await _tokenStorage.getAccessToken();
    
    if (accessToken == null || accessToken.isEmpty) {
      return false;
    }

    // Check if token is expired
    return !_isTokenExpired(accessToken);
  }

  /// Check if a JWT token is expired
  /// 
  /// Returns true if token is expired or invalid format
  bool _isTokenExpired(String token) {
    try {
      // JWT tokens have 3 parts separated by dots: header.payload.signature
      final parts = token.split('.');
      if (parts.length != 3) {
        return true; // Invalid token format
      }

      // Decode the payload (second part)
      // Add padding if needed for base64 decoding
      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final payloadMap = json.decode(decoded) as Map<String, dynamic>;

      // Check expiration claim (exp is in seconds since epoch)
      if (payloadMap.containsKey('exp')) {
        final exp = payloadMap['exp'] as int;
        final expirationDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
        final now = DateTime.now();
        
        // Token is expired if expiration date is in the past
        return now.isAfter(expirationDate);
      }

      // If no exp claim, consider token invalid
      return true;
    } catch (e) {
      // If we can't decode the token, consider it expired/invalid
      return true;
    }
  }

  /// Logout by clearing all stored tokens
  Future<void> logout() async {
    await _tokenStorage.deleteAllTokens();
  }
}
