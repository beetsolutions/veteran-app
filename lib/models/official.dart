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
}
