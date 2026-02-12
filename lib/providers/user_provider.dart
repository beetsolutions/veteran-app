import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../models/organization.dart';
import '../data/api/auth_api.dart';
import '../data/api/api_client.dart';

/// Provider for managing user state and organization switching
class UserProvider extends ChangeNotifier {
  User? _currentUser;
  final AuthApi _authApi;

  UserProvider({AuthApi? authApi}) 
      : _authApi = authApi ?? AuthApi(ApiClient());

  /// Get the current user
  User? get currentUser => _currentUser;

  /// Get the current organization
  Organization? get currentOrganization => _currentUser?.currentOrganization;

  /// Set the current user (typically after login)
  void setUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  /// Clear the current user (typically after logout)
  void clearUser() {
    _currentUser = null;
    notifyListeners();
  }

  /// Get available organizations for the current user
  List<Organization> get organizations => _currentUser?.organizations ?? [];

  /// Switch to a different organization
  Future<void> switchOrganization(String organizationId) async {
    if (_currentUser == null) {
      throw Exception('No user logged in');
    }

    // Find the organization - use orElse to handle missing organization
    final organization = _currentUser!.organizations
        .firstWhere(
          (org) => org.id == organizationId,
          orElse: () => throw Exception("Organization not found in user's organizations"),
        );

    // Call the API to switch organization
    await _authApi.switchOrganization(organizationId);

    // Update the user with the new current organization ID
    _currentUser = _currentUser!.copyWith(
      currentOrganizationId: organizationId,
    );

    notifyListeners();
  }

  /// Check if user has multiple organizations
  bool get hasMultipleOrganizations => organizations.length > 1;
}
