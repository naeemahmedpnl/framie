class AppointmentData {
  final String id;
  final String userId;
  final String adminId;
  final String clientName;
  final String date;
  final List<String> services;
  final String stylist;
  final String timeSlot;
  final int price;
  final String createdByModel;
  final String createdBy;
  final String status;
  final String createdAt;
  final String updatedAt;

  AppointmentData({
    required this.id,
    required this.userId,
    required this.adminId,
    required this.clientName,
    required this.date,
    required this.services,
    required this.stylist,
    required this.timeSlot,
    required this.price,
    required this.createdByModel,
    required this.createdBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppointmentData.fromJson(Map<String, dynamic> json) {
    return AppointmentData(
      id: json['_id'],
      userId: json['userId'],
      adminId: json['adminId'],
      clientName: json['clientName'],
      date: json['date'],
      services: List<String>.from(json['services']),
      stylist: json['stylist'],
      timeSlot: json['timeSlot'],
      price: json['price'],
      createdByModel: json['createdByModel'],
      createdBy: json['createdBy'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
