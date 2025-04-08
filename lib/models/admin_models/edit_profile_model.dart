class EditProfileModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String city;
  final String? profileImage;
  final DateTime createdAt;
  final DateTime updatedAt;

  EditProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.city,
    this.profileImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(
      id: json["_id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      city: json["city"],
      profileImage: json["profileImage"] ?? "",
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "city": city,
      "profileImage": profileImage,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }
}
