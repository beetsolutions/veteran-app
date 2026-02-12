import 'organization.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String name;
  final List<Organization> organizations;
  final String? currentOrganizationId;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    this.organizations = const [],
    this.currentOrganizationId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      organizations: json['organizations'] != null
          ? (json['organizations'] as List)
              .map((org) => Organization.fromJson(org as Map<String, dynamic>))
              .toList()
          : [],
      currentOrganizationId: json['currentOrganizationId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'name': name,
      'organizations': organizations.map((org) => org.toJson()).toList(),
      'currentOrganizationId': currentOrganizationId,
    };
  }

  /// Get the current organization object from the list
  Organization? get currentOrganization {
    if (currentOrganizationId == null) return null;
    try {
      return organizations.firstWhere((org) => org.id == currentOrganizationId);
    } catch (e) {
      return null;
    }
  }

  /// Create a copy of this user with updated fields
  User copyWith({
    String? id,
    String? username,
    String? email,
    String? name,
    List<Organization>? organizations,
    String? currentOrganizationId,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      name: name ?? this.name,
      organizations: organizations ?? this.organizations,
      currentOrganizationId: currentOrganizationId ?? this.currentOrganizationId,
    );
  }
}
