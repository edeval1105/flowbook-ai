class Professional {
  final String id;
  final String name;

  Professional({
    required this.id,
    required this.name,
  });

  factory Professional.fromJson(Map<String, dynamic> json) {
    return Professional(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}