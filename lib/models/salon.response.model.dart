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
  String? title;
  String? text;
  String? bannerImage;
  String? createdAt;
  String? updatedAt;
  int? v;

  ServiceSalon({
    this.id,
    this.adminId,
    this.title,
    this.text,
    this.bannerImage,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ServiceSalon.fromJson(Map<String, dynamic> json) {
    return ServiceSalon(
      id: json['_id'],
      adminId: json['adminId'],
      title: json['Title'],
      text: json['text'],
      bannerImage: json['bannerImage'],
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
