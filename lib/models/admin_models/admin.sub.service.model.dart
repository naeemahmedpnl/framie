class AddSubService {
  final String adminId;
  final String serviceId;
  final String title;
  final String text;
  final String price;

  AddSubService({
    required this.adminId,
    required this.serviceId,
    required this.title,
    required this.text,
    required this.price,
  });

  factory AddSubService.fromJson(Map<String, dynamic> json) {
    return AddSubService(
      serviceId: json['serviceId'],
      adminId: json['adminId'],
      title: json['title'],
      text: json['text'],
      price: json['price'],
    );
  }
}
