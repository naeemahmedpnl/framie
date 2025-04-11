
class AllEmployees {
  final String id;
  final String createdBy;
  final String employeeName;
  final String about;
  final List<AvailableService> availableServices;
  final List<WorkingDay> workingDays;
  final String employeeImage;

  AllEmployees({
    required this.id,
    required this.createdBy,
    required this.employeeName,
    required this.about,
    required this.availableServices,
    required this.workingDays,
    required this.employeeImage,
  });

  factory AllEmployees.fromJson(Map<String, dynamic> json) => AllEmployees(
        id: json["_id"],
        createdBy: json["createdBy"],
        employeeName: json["employeeName"],
        about: json["about"],
       availableServices: (json["availableServices"] as List<dynamic>?)
                ?.map((x) => AvailableService.fromJson(x))
                .toList() ??
            [],
      workingDays: (json["workinDays"] as List<dynamic>?)
                ?.map((x) => WorkingDay.fromJson(x))
                .toList() ??
            [],
        employeeImage: json["employeeImage"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "createdBy": createdBy,
        "employeeName": employeeName,
        "about": about,
        "availableServices":
            List<dynamic>.from(availableServices.map((x) => x)),
        "workinDays": List<dynamic>.from(workingDays.map((x) => x.toJson())),
        "employeeImage": employeeImage,
      };
}


class AvailableService {
  final String id;
  final String title;

  AvailableService({
    required this.id,
    required this.title,
  });

  factory AvailableService.fromJson(Map<String, dynamic> json) => AvailableService(
        id: json["_id"] ?? "",
        title: json["Title"] ?? "", // Note: API uses "Title" with a capital 'T'
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "Title": title,
      };
}

class WorkingDay {
  final String day;
  final bool isActive;
  final String startTime;
  final String endTime;
  final String id;

  WorkingDay({
    required this.day,
    required this.isActive,
    required this.startTime,
    required this.endTime,
    required this.id,
  });

  factory WorkingDay.fromJson(Map<String, dynamic> json) => WorkingDay(
        day: json["day"],
        isActive: json["isActive"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "isActive": isActive,
        "startTime": startTime,
        "endTime": endTime,
        "_id": id,
      };
}
