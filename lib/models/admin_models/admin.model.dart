class AdminModel {
  String id;
  String? name;
  String? profileImage;
  String? email;
  String? phNumber; // Changed to String
  bool? isVerified;

  AdminModel({
    this.name,
    required this.id,
    this.email,
    this.profileImage = "",
    this.phNumber,
    this.isVerified = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'email': email,
      'phNumber': phNumber,
      'profileImage': profileImage,
      'isVerified': isVerified,
    };
  }

  Map<String, dynamic> toJsonForSession() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['email'] = email;
    data['phNumber'] = phNumber;
    data['profileImage'] = profileImage;
    data['isVerified'] = isVerified;

    return data;
  }

  factory AdminModel.empty() {
    return AdminModel(
      id: '',
      name: '',
      email: '',
      phNumber: '',
      isVerified: false,
      profileImage: '',
    );
  }

  static AdminModel initialUser = AdminModel(
    email: "",
    name: "",
    phNumber: "",
    profileImage: "",
    id: "",
    isVerified: false,
  );

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      name: map['name'] as String?,
      id: map['id'] as String,
      email: map['email'] as String?,
      phNumber: map['phNumber']?.toString(), 
      profileImage: map['profileImage'] as String?,
      isVerified: map['isVerified'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'email': email,
      'phNumber': phNumber,
      'profileImage': profileImage,
      'isVerified': isVerified,
    };
  }

  factory AdminModel.fromJson(Map<String, dynamic> map) {
    Map<String, dynamic> userData = map['data'] ?? {};
    return AdminModel(
      name: userData['name'] ?? '',
      id: userData['id'] ?? '',
      email: userData['email'] ?? '',
      phNumber: userData['phNumber']?.toString() ?? '', 
      profileImage: userData['profileImage'] ?? '',
      isVerified: userData['isVerified'] ?? false,
    );
  }

  bool get isProfileEmpty {
    return profileImage == null || profileImage!.isEmpty;
  }
}
