class AllEmployees {
  final String id;
  final String adminId;
  final String businessName;
  final String userName;
  final String city;
  final String address;
  final List<String> availableServices;
  final List<WorkingDay> workingDays;
  final String profileImage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  AllEmployees({
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
    required this.v,
  });

  factory AllEmployees.fromJson(Map<String, dynamic> json) => AllEmployees(
        id: json["_id"],
        adminId: json["adminId"],
        businessName: json["businessName"],
        userName: json["userName"],
        city: json["city"],
        address: json["address"],
        availableServices: List<String>.from(json["availableServices"] ?? []),
        workingDays: (json["workingDays"] as List<dynamic>?)
                ?.map((x) => WorkingDay.fromJson(x))
                .toList() ??
            [],
        profileImage: json["profileImage"] ?? '',
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "adminId": adminId,
        "businessName": businessName,
        "userName": userName,
        "city": city,
        "address": address,
        "availableServices":
            List<dynamic>.from(availableServices.map((x) => x)),
        "workingDays": List<dynamic>.from(workingDays.map((x) => x.toJson())),
        "profileImage": profileImage,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class WorkingDay {
  final String day;
  final bool isActive;
  final String openingTime;
  final String closeingTime;
  final String id;

  WorkingDay({
    required this.day,
    required this.isActive,
    required this.openingTime,
    required this.closeingTime,
    required this.id,
  });

  factory WorkingDay.fromJson(Map<String, dynamic> json) => WorkingDay(
        day: json["day"],
        isActive: json["isActive"],
        openingTime: json["openingTime"],
        closeingTime: json["closeingTime"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "isActive": isActive,
        "openingTime": openingTime,
        "closeingTime": closeingTime,
        "_id": id,
      };
}