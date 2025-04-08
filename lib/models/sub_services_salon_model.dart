class SubServiceSalon {
  final String id;
  final String adminId;
  final String serviceId;
  final String title;
  final String text;
  final List<String> subServiceImage;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;

  SubServiceSalon({
    required this.id,
    required this.adminId,
    required this.serviceId,
    required this.title,
    required this.text,
    required this.subServiceImage,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubServiceSalon.fromJson(Map<String, dynamic> json) {
    return SubServiceSalon(
      id: json['_id'],
      adminId: json['adminId'],
      serviceId: json['serviceId'],
      title: json['title'],
      text: json['text'],
      subServiceImage: List<String>.from(json['subServiceImage']),
      price: json['price'].toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'adminId': adminId,
      'serviceId': serviceId,
      'title': title,
      'text': text,
      'subServiceImage': subServiceImage,
      'price': price,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
