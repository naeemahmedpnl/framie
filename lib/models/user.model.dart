class UserModel {
  String id;
  String? name;
  String? profile = "";
  String? email;
  int? phNumber;
  String? userType;
  String? city;
  bool? isVerified;

  UserModel({
    this.name,
    required this.id,
    this.email,
    this.profile,
    this.phNumber,
    this.isVerified = false,
    this.userType = "user",
    this.city = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'email': email,
      'phNumber': phNumber,
      'profile': profile,
      'userType': userType,
      'isVerified': isVerified,
      'city': city,
    };
  }

  Map<String, dynamic> toJsonForSession() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['id'] = id;
    data['email'] = email;
    data['phNumber'] = phNumber;
    data['userType'] = userType;
    data['profile'] = profile;
    data['isVerified'] = isVerified;
    data['city'] = city;

    return data;
  }

  factory UserModel.empty() {
    return UserModel(
      id: '',
      name: '',
      email: '',
      phNumber: 0,
      isVerified: false,
      profile: '',
      city: '',
      userType: '',
    );
  }

  static UserModel initialUser = UserModel(
    email: "",
    name: "",
    phNumber: 0,
    profile: "",
    id: "",
    isVerified: false,
    userType: "student",
    city: '',
  );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String?,
      id: map['id'] as String,
      email: map['email'] as String?,
      phNumber: map['phNumber'] as int?,
      profile: map['profile'] as String?,
      isVerified: map['isVerified'] as bool?,
      city: map['city'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'email': email,
      'phNumber': phNumber,
      'profile': profile,
      'isVerified': isVerified,
      'city': city,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      phNumber: map['phNumber'] ?? 0,
      profile: map['profile'] ?? '',
      userType: map['userType'] ?? 'student',
      isVerified: map['isVerified'] ?? false,
      city: map['city'] ?? '',
    );
  }

  bool get isProfileEmpty {
    return profile == '';
  }

  bool get isUserTypeAdmin {
    return userType == 'Admin';
  }
}
