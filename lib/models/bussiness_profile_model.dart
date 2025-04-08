class BusinessProfile {
  final String adminId;
  final String businessName;
  final String userName;
  final String city;
  final String address;
  final List<String> availableServices;
  final List<WorkingDay> workingDays;
  final String? businessImageUrl;

  BusinessProfile({
    required this.adminId,
    required this.businessName,
    required this.userName,
    required this.city,
    required this.address,
    required this.availableServices,
    required this.workingDays,
    this.businessImageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'adminId': adminId,
      'businessName': businessName,
      'userName': userName,
      'city': city,
      'address': address,
      'availableServices': availableServices,
      'workingDays': workingDays.map((day) => day.toJson()).toList(),
    };
  }

  // Create model from JSON response
  factory BusinessProfile.fromJson(Map<String, dynamic> json) {
    return BusinessProfile(
      adminId: json['adminId'],
      businessName: json['businessName'],
      userName: json['userName'],
      city: json['city'],
      address: json['address'],
      availableServices: List<String>.from(json['availableServices']),
      workingDays: (json['workingDays'] as List)
          .map((day) => WorkingDay.fromJson(day))
          .toList(),
      businessImageUrl: json['businessImageUrl'],
    );
  }
}

class WorkingDay {
  final String day;
  final bool isActive;
  final String openingTime;
  final String closeingTime;

  WorkingDay({
    required this.day,
    required this.isActive,
    required this.openingTime,
    required this.closeingTime,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'isActive': isActive,
      'openingTime': openingTime,
      'closeingTime': closeingTime,
    };
  }

  // Create from JSON
  factory WorkingDay.fromJson(Map<String, dynamic> json) {
    return WorkingDay(
      day: json['day'],
      isActive: json['isActive'],
      openingTime: json['openingTime'],
      closeingTime: json['closeingTime'],
    );
  }
}
