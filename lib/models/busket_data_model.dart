import 'package:uuid/uuid.dart';

import 'admin_models/all_employees_model.dart';
import 'salon.response.model.dart';

class CombinedBasketModel {
  final String id; // No longer optional, always required
  final BasketDataModel basketData;
  final ServiceSalon salon;
  final AllEmployees employee;

  CombinedBasketModel({
    String? id, // Can be passed as optional to constructor
    required this.basketData,
    required this.salon,
    required this.employee,
  }) : id = id ?? Uuid().v4();
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'basketData': basketData.toJson(),
      'salon': salon.toJson(),
      'employee': employee.toJson(),
    };
  }

  factory CombinedBasketModel.fromJson(Map<String, dynamic> json) {
    return CombinedBasketModel(
      id: json['id'] as String,
      basketData:
          BasketDataModel.fromJson(json['basketData'] as Map<String, dynamic>),
      salon: ServiceSalon.fromJson(json['salon'] as Map<String, dynamic>),
      employee: AllEmployees.fromJson(json['employee'] as Map<String, dynamic>),
    );
  }
}

class BasketDataModel {
  final String userId;
  final String adminId;
  final String clientName;
  final String date;
  final List<String> services;
  final String? stylist; // Changed to nullable String?
  final String timeSlot;
  final String price;
  final String createdByModel;
  final String createdBy;

  BasketDataModel({
    required this.userId,
    required this.adminId,
    required this.clientName,
    required this.date,
    required this.services,
    this.stylist, // Nullable, no longer required
    required this.timeSlot,
    required this.price,
    required this.createdByModel,
    required this.createdBy,
  });


  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'adminId': adminId,
      'clientName': clientName,
      'date': date,
      'stylist': stylist,
      'timeSlot': timeSlot,
      'price': price,
      'createdByModel': createdByModel,
      'createdBy': createdBy,
      'services': services,
    };
  }

  factory BasketDataModel.fromJson(Map<String, dynamic> json) =>
      BasketDataModel(
        userId: json['userId'],
        adminId: json['adminId'],
        clientName: json['clientName'],
        date: json['date'],
        stylist: json['stylist'],
        timeSlot: json['timeSlot'],
        price: json['price'],
        createdByModel: json['createdByModel'],
        createdBy: json['createdBy'],
        services: (json['services'] as List).map((e) => e.toString()).toList(),
      );
}
