class Official {
  final String name;
  final String role;
  final String service;
  final String? imageUrl;

  const Official({
    required this.name,
    required this.role,
    required this.service,
    this.imageUrl,
  });

  factory Official.fromJson(Map<String, dynamic> json) {
    return Official(
      name: json['name'] as String,
      role: json['role'] as String,
      service: json['service'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'service': service,
      'imageUrl': imageUrl,
    };
  }
}
