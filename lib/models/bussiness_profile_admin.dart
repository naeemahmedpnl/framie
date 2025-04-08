class BusinessProfileAdmin {
  final bool success;
  final String msg;
  final BusinessDataAdmin data;

  BusinessProfileAdmin({
    required this.success,
    required this.msg,
    required this.data,
  });

  factory BusinessProfileAdmin.fromJson(Map<String, dynamic> json) {
    return BusinessProfileAdmin(
      success: json['success'],
      msg: json['msg'],
      data: BusinessDataAdmin.fromJson(json['data']),
    );
  }
}

class BusinessDataAdmin {
  final String id;
  final String adminId;
  final String businessName;
  final String userName;
  final String city;
  final String address;
  final List<String> availableServices;
  final List<WorkingDayAdmin> workingDays;
  final String profileImage;
  final String createdAt;
  final String updatedAt;

  BusinessDataAdmin({
    required this.id,
    required this.adminId,
    required this.businessName,
    required this.userName,
    required this.city,
    required this.address,
    required this.availableServices,
    required this.workingDays,
    required this.profileImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BusinessDataAdmin.fromJson(Map<String, dynamic> json) {
    return BusinessDataAdmin(
      id: json['_id'],
      adminId: json['adminId'],
      businessName: json['businessName'],
      userName: json['userName'],
      city: json['city'],
      address: json['address'],
      availableServices: List<String>.from(json['availableServices']),
      workingDays: (json['workingDays'] as List)
          .map((e) => WorkingDayAdmin.fromJson(e))
          .toList(),
      profileImage: json['profileImage'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class WorkingDayAdmin {
  final String day;
  final bool isActive;
  final String openingTime;
  final String closeingTime;
  final String id;

  WorkingDayAdmin({
    required this.day,
    required this.isActive,
    required this.openingTime,
    required this.closeingTime,
    required this.id,
  });

  factory WorkingDayAdmin.fromJson(Map<String, dynamic> json) {
    return WorkingDayAdmin(
      day: json['day'],
      isActive: json['isActive'],
      openingTime: json['openingTime'],
      closeingTime: json['closeingTime'],
      id: json['_id'],
    );
  }
}
