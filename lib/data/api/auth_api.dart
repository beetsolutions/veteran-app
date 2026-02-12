import 'api_client.dart';
import '../../models/user.dart';
import '../../models/organization.dart';
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
      
      // Store user ID
      await _tokenStorage.saveUserId(authResponse.user.id);
      
      // Store current organization ID if available
      if (authResponse.user.currentOrganizationId != null) {
        await _tokenStorage.saveCurrentOrganizationId(
          authResponse.user.currentOrganizationId!,
        );
      }
      
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

  /// Get user's organizations
  /// 
  /// Returns a list of organizations the user belongs to.
  /// Requires valid access token.
  /// 
  /// Throws [ApiException] with:
  /// - statusCode 401: Invalid or expired token
  /// - statusCode 0: Network error
  Future<List<Organization>> getOrganizations() async {
    final data = await _client.get('/auth/organizations');

    if (data['success'] == true) {
      final organizations = (data['organizations'] as List)
          .map((org) => Organization.fromJson(org as Map<String, dynamic>))
          .toList();
      return organizations;
    } else {
      throw ApiException(
        data['message'] ?? 'Failed to get organizations',
        401,
      );
    }
  }

  /// Switch to a different organization
  /// 
  /// Returns the new current organization ID.
  /// Automatically updates the stored organization ID.
  /// 
  /// Throws [ApiException] with:
  /// - statusCode 401: Invalid or expired token
  /// - statusCode 403: User doesn't belong to this organization
  /// - statusCode 404: Organization not found
  /// - statusCode 0: Network error
  Future<String> switchOrganization(String organizationId) async {
    final data = await _client.post('/auth/switch-organization', {
      'organizationId': organizationId,
    });

    if (data['success'] == true) {
      final currentOrganizationId = data['currentOrganizationId'] as String;
      
      // Update stored organization ID
      await _tokenStorage.saveCurrentOrganizationId(currentOrganizationId);
      
      return currentOrganizationId;
    } else {
      throw ApiException(
        data['message'] ?? 'Failed to switch organization',
        data['statusCode'] ?? 400,
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
