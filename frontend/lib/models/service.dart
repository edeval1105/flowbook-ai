class ServiceModel {
  final String id;
  final String name;
  final double price;

  ServiceModel({
    required this.id,
    required this.name,
    required this.price,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }
}