class SalonServicesModel {
  bool? success;
  String? msg;
  List<ServiceSalon>? data;

  SalonServicesModel({this.success, this.msg, this.data});

  factory SalonServicesModel.fromJson(Map<String, dynamic> json) {
    return SalonServicesModel(
      success: json['success'],
      msg: json['msg'],
      data: json['data'] != null
          ? List<ServiceSalon>.from(
              json['data'].map(
                (x) => ServiceSalon.fromJson(x),
              ),
            )
          : [],
    );
  }
}

class ServiceSalon {
  String? id;
  String? adminId;
  String? serviceId;
  String? title;
  String? text;
  String? bannerImage;
  int? price;
  String? createdAt;
  String? updatedAt;
  int? v;

  ServiceSalon({
    this.id,
    this.adminId,
    this.serviceId,
    this.title,
    this.text,
    this.bannerImage,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ServiceSalon.fromJson(Map<String, dynamic> json) {
    return ServiceSalon(
      id: json['_id'],
      adminId: json['adminId'],
      serviceId: json['serviceId'],
      title:
          json['Title'] ?? json['title'],
      text: json['text'],
      bannerImage:
          json['subServiceImage'] != null && json['subServiceImage'].isNotEmpty
              ? json['subServiceImage'][0]
              : json['bannerImage'], // Try both field names
      price: json['price']?.toDouble(),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "adminId": adminId,
        "Title": title,
        "text": text,
        "bannerImage": bannerImage,
        "updatedAt": updatedAt,
      };
}
