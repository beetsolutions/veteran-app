import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:veteranapp/data/services/auth_service.dart';
import 'package:veteranapp/data/storage/auth_token_storage.dart';

void main() {
  group('AuthService', () {
    late AuthService authService;
    late AuthTokenStorage tokenStorage;
    late MockSecureStorage mockStorage;

    setUp(() {
      mockStorage = MockSecureStorage();
      tokenStorage = AuthTokenStorage(storage: mockStorage);
      authService = AuthService(tokenStorage: tokenStorage);
    });

    group('isAuthenticated', () {
      test('returns false when no token is stored', () async {
        // Arrange - storage is empty by default

        // Act
        final result = await authService.isAuthenticated();

        // Assert
        expect(result, false);
      });

      test('returns false when token is expired', () async {
        // Arrange - Create an expired token (exp in the past)
        final expiredToken = _createTestToken(expiresIn: -3600); // expired 1 hour ago
        await tokenStorage.saveAccessToken(expiredToken);

        // Act
        final result = await authService.isAuthenticated();

        // Assert
        expect(result, false);
      });

      test('returns true when token is valid and not expired', () async {
        // Arrange - Create a valid token (exp in the future)
        final validToken = _createTestToken(expiresIn: 3600); // expires in 1 hour
        await tokenStorage.saveAccessToken(validToken);

        // Act
        final result = await authService.isAuthenticated();

        // Assert
        expect(result, true);
      });

      test('returns false when token format is invalid', () async {
        // Arrange - Invalid token format (not 3 parts)
        await tokenStorage.saveAccessToken('invalid.token');

        // Act
        final result = await authService.isAuthenticated();

        // Assert
        expect(result, false);
      });

      test('returns false when token has no exp claim', () async {
        // Arrange - Create a token without exp claim
        final tokenWithoutExp = _createTestTokenWithoutExp();
        await tokenStorage.saveAccessToken(tokenWithoutExp);

        // Act
        final result = await authService.isAuthenticated();

        // Assert
        expect(result, false);
      });
    });

    group('logout', () {
      test('clears all tokens from storage', () async {
        // Arrange
        final token = _createTestToken(expiresIn: 3600);
        await tokenStorage.saveTokens(
          accessToken: token,
          refreshToken: 'refresh.token.here',
        );

        // Act
        await authService.logout();

        // Assert
        final accessToken = await tokenStorage.getAccessToken();
        final refreshToken = await tokenStorage.getRefreshToken();
        expect(accessToken, null);
        expect(refreshToken, null);
      });
    });
  });
}

/// Helper function to create a test JWT token with a specific expiration
String _createTestToken({required int expiresIn}) {
  // Calculate expiration timestamp (seconds since epoch)
  final now = DateTime.now();
  final expiration = now.add(Duration(seconds: expiresIn));
  final exp = expiration.millisecondsSinceEpoch ~/ 1000;

  // Create a simple JWT payload with exp claim
  final payload = '{"exp": $exp, "userId": "test123"}';
  
  // Base64 encode the payload (simulating JWT structure)
  final encodedPayload = _base64UrlEncode(payload);
  
  // Return a mock JWT token (header.payload.signature)
  return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.$encodedPayload.signature';
}

/// Helper function to create a test JWT token without exp claim
String _createTestTokenWithoutExp() {
  final payload = '{"userId": "test123"}';
  final encodedPayload = _base64UrlEncode(payload);
  return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.$encodedPayload.signature';
}

/// Base64 URL encode helper
String _base64UrlEncode(String input) {
  // Use utf8.encode to properly convert string to bytes
  final bytes = utf8.encode(input);
  // Use standard base64Url encoding from dart:convert
  return base64Url.encode(bytes).replaceAll('=', '');
}

/// Mock implementation of FlutterSecureStorage for testing
class MockSecureStorage implements FlutterSecureStorage {
  final Map<String, String> _data = {};

  @override
  Future<void> write({required String key, required String value, IOSOptions? iOptions, AndroidOptions? aOptions, LinuxOptions? lOptions, WebOptions? webOptions, MacOsOptions? mOptions, WindowsOptions? wOptions}) async {
    _data[key] = value;
  }

  @override
  Future<String?> read({required String key, IOSOptions? iOptions, AndroidOptions? aOptions, LinuxOptions? lOptions, WebOptions? webOptions, MacOsOptions? mOptions, WindowsOptions? wOptions}) async {
    return _data[key];
  }

  @override
  Future<void> delete({required String key, IOSOptions? iOptions, AndroidOptions? aOptions, LinuxOptions? lOptions, WebOptions? webOptions, MacOsOptions? mOptions, WindowsOptions? wOptions}) async {
    _data.remove(key);
  }

  @override
  Future<void> deleteAll({IOSOptions? iOptions, AndroidOptions? aOptions, LinuxOptions? lOptions, WebOptions? webOptions, MacOsOptions? mOptions, WindowsOptions? wOptions}) async {
    _data.clear();
  }

  @override
  Future<Map<String, String>> readAll({IOSOptions? iOptions, AndroidOptions? aOptions, LinuxOptions? lOptions, WebOptions? webOptions, MacOsOptions? mOptions, WindowsOptions? wOptions}) async {
    return Map.from(_data);
  }

  @override
  Future<bool> containsKey({required String key, IOSOptions? iOptions, AndroidOptions? aOptions, LinuxOptions? lOptions, WebOptions? webOptions, MacOsOptions? mOptions, WindowsOptions? wOptions}) async {
    return _data.containsKey(key);
  }
}
