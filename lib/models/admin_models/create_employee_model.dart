class CreateAllEmployees {
  final String createdBy;
  final String employeeName;
  final String about;
  final List<String> availableServices;
  final List<WorkingDay> workingDays;

  CreateAllEmployees({
    required this.createdBy,
    required this.employeeName,
    required this.about,
    required this.availableServices,
    required this.workingDays,
  });

  factory CreateAllEmployees.fromJson(Map<String, dynamic> json) =>
      CreateAllEmployees(
        createdBy: json["createdBy"],
        employeeName: json["employeeName"],
        about: json["about"],
        availableServices: List<String>.from(json["availableServices"] ?? []),
        workingDays: (json["workinDays"] as List<dynamic>?)
                ?.map((x) => WorkingDay.fromJson(x))
                .toList() ??
            [],
      );
  Map<String, dynamic> toJsonWithoutId() {
    final map = {
      "createdBy": createdBy,
      "employeeName": employeeName,
      "about": about,
      "availableServices": List<dynamic>.from(availableServices.map((x) => x)),
      "workinDays": List<dynamic>.from(workingDays.map((x) => x.toJson())),
    };
    return map;
  }

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "employeeName": employeeName,
        "about": about,
        "availableServices":
            List<dynamic>.from(availableServices.map((x) => x)),
        "workinDays": List<dynamic>.from(workingDays.map((x) => x.toJson())),
      };
}

class WorkingDay {
  final String day;
  final bool isActive;
  final String startTime;
  final String endTime;

  WorkingDay({
    required this.day,
    required this.isActive,
    required this.startTime,
    required this.endTime,
  });

  factory WorkingDay.fromJson(Map<String, dynamic> json) => WorkingDay(
        day: json["day"],
        isActive: json["isActive"],
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "isActive": isActive,
        "startTime": startTime,
        "endTime": endTime,
      };
}
