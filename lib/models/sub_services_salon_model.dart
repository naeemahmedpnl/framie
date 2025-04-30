
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




class SubServicesModel {
  final bool success;
  final String msg;
  final List<SubService> data;

  SubServicesModel({
    required this.success,
    required this.msg,
    required this.data,
  });

  factory SubServicesModel.fromJson(Map<String, dynamic> json) {
    return SubServicesModel(
      success: json['success'] ?? false,
      msg: json['msg'] ?? '',
      data: json['data'] != null
          ? List<SubService>.from(
              json['data'].map((x) => SubService.fromJson(x)))
          : [],
    );
  }
}

class SubService {
  final String id;
  final String adminId;
  final String serviceId;
  final List<AssignedEmployee> assignedTo;
  final String title;
  final String text;
  final List<String> subServiceImage;
  final double price;
  final int? servicePoints;
  final String createdAt;
  final String updatedAt;

  SubService({
    required this.id,
    required this.adminId,
    required this.serviceId,
    required this.assignedTo,
    required this.title,
    required this.text,
    required this.subServiceImage,
    required this.price,
    this.servicePoints,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubService.fromJson(Map<String, dynamic> json) {
    return SubService(
      id: json['_id'] ?? '',
      adminId: json['adminId'] ?? '',
      serviceId: json['serviceId'] ?? '',
      assignedTo: json['assignedTo'] != null
          ? List<AssignedEmployee>.from(
              json['assignedTo'].map((x) => AssignedEmployee.fromJson(x)))
          : [],
      title: json['title'] ?? '',
      text: json['text'] ?? '',
      subServiceImage: json['subServiceImage'] != null
          ? List<String>.from(json['subServiceImage'])
          : [],
      price: json['price'] != null ? json['price'].toDouble() : 0.0,
      servicePoints: json['servicePoints'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'adminId': adminId,
      'serviceId': serviceId,
      'assignedTo': assignedTo.map((e) => e.toJson()).toList(),
      'title': title,
      'text': text,
      'subServiceImage': subServiceImage,
      'price': price,
      'servicePoints': servicePoints,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class AssignedEmployee {
  final String id;
  final String createdBy;
  final String employeeName;
  final String about;
  final List<String> availableServices;
  final List<WorkingDay> workingDays;
  final String employeeImage;

  AssignedEmployee({
    required this.id,
    required this.createdBy,
    required this.employeeName,
    required this.about,
    required this.availableServices,
    required this.workingDays,
    required this.employeeImage,
  });

  factory AssignedEmployee.fromJson(Map<String, dynamic> json) {
    return AssignedEmployee(
      id: json['_id'] ?? '',
      createdBy: json['createdBy'] ?? '',
      employeeName: json['employeeName'] ?? '',
      about: json['about'] ?? '',
      availableServices: json['availableServices'] != null
          ? List<String>.from(json['availableServices'])
          : [],
      workingDays: json['workinDays'] != null
          ? List<WorkingDay>.from(
              json['workinDays'].map((x) => WorkingDay.fromJson(x)))
          : [],
      employeeImage: json['employeeImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'createdBy': createdBy,
      'employeeName': employeeName,
      'about': about,
      'availableServices': availableServices,
      'workinDays': workingDays.map((e) => e.toJson()).toList(),
      'employeeImage': employeeImage,
    };
  }
}

class WorkingDay {
  final String id;
  final String day;
  final bool isActive;
  final String startTime;
  final String endTime;

  WorkingDay({
    required this.id,
    required this.day,
    required this.isActive,
    required this.startTime,
    required this.endTime,
  });

  factory WorkingDay.fromJson(Map<String, dynamic> json) {
    return WorkingDay(
      id: json['_id'] ?? '',
      day: json['day'] ?? '',
      isActive: json['isActive'] ?? false,
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'day': day,
      'isActive': isActive,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}

// class SubService {
//   final String id;
//   final String adminId;
//   final String serviceId;
//   final List<Employees> assignedTo;  
//   final String title;
//   final String text;
//   final List<String> subServiceImage;
//   final double price;
//   final int? servicePoints;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   SubService({
//     required this.id,
//     required this.adminId,
//     required this.serviceId,
//     required this.assignedTo,
//     required this.title,
//     required this.text,
//     required this.subServiceImage,
//     required this.price,
//     this.servicePoints,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//  factory SubService.fromJson(Map<String, dynamic> json) {
//   try {
//     return SubService(
//       id: json['_id'],
//       adminId: json['adminId'],
//       serviceId: json['serviceId'],
//       assignedTo: (json['assignedTo'] as List)
//           .map((e) => Employees.fromJson(e as Map<String, dynamic>))
//           .toList(),
//       title: json['title'],
//       text: json['text'],
//       subServiceImage: List<String>.from(json['subServiceImage']),
//       price: json['price'] is int 
//           ? (json['price'] as int).toDouble() 
//           : json['price'].toDouble(),
//       servicePoints: json['servicePoints'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//     );
//   } catch (e) {
//     log('Error parsing SubService: $e');
//     rethrow;
//   }
// }
// }
