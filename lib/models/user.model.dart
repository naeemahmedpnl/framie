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


// class UserModel {
//   String id;
//   String? firstName;
//   String? lastName;
//   String? email;
//   dynamic phNumber; // Changed to dynamic to handle both int and String
//   String? userType;
//   String? city;
//   bool? isVerified;
//   String? profile; // Keeping your profile field

//   UserModel({
//     required this.id,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.profile = "",
//     this.phNumber,
//     this.isVerified = false,
//     this.userType = "user",
//     this.city = '',
//   });

//   // Get full name from firstName and lastName
//   String? get name => firstName != null && lastName != null 
//       ? "$firstName $lastName" 
//       : firstName ?? lastName;

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'firstName': firstName,
//       'lastName': lastName,
//       'email': email,
//       'phNumber': phNumber,
//       'profile': profile,
//       'userType': userType,
//       'isVerified': isVerified,
//       'city': city,
//     };
//   }

//   Map<String, dynamic> toJsonForSession() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['firstName'] = firstName;
//     data['lastName'] = lastName;
//     data['id'] = id;
//     data['email'] = email;
//     data['phNumber'] = phNumber;
//     data['userType'] = userType;
//     data['profile'] = profile;
//     data['isVerified'] = isVerified;
//     data['city'] = city;
//     return data;
//   }

//   factory UserModel.empty() {
//     return UserModel(
//       id: '',
//       firstName: '',
//       lastName: '',
//       email: '',
//       phNumber: 0,
//       isVerified: false,
//       profile: '',
//       city: '',
//       userType: '',
//     );
//   }

//   static UserModel initialUser = UserModel(
//     email: "",
//     firstName: "",
//     lastName: "",
//     phNumber: 0,
//     profile: "",
//     id: "",
//     isVerified: false,
//     userType: "user",
//     city: '',
//   );

//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       firstName: map['firstName'] as String?,
//       lastName: map['lastName'] as String?,
//       id: map['id'] as String,
//       email: map['email'] as String?,
//       phNumber: map['phNumber'],
//       profile: map['profile'] as String?,
//       isVerified: map['isVerified'] as bool?,
//       city: map['city'] as String?,
//       userType: map['userType'] as String?,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'firstName': firstName,
//       'lastName': lastName,
//       'id': id,
//       'email': email,
//       'phNumber': phNumber,
//       'profile': profile,
//       'isVerified': isVerified,
//       'city': city,
//       'userType': userType,
//     };
//   }

//   // Create from API response
//   factory UserModel.fromApiResponse(Map<String, dynamic> map) {
//     return UserModel(
//       id: map['_id'] ?? '',
//       firstName: map['firstName'] ?? '',
//       lastName: map['lastName'] ?? '',
//       email: map['email'] ?? '',
//       phNumber: map['phNumber'],
//       profile: map['profile'] ?? '',
//       isVerified: map['isVerified'] ?? false,
//       city: map['city'] ?? '',
//       userType: map['userType'] ?? 'user',
//     );
//   }

//   factory UserModel.fromJson(Map<String, dynamic> map) {
//     return UserModel(
//       firstName: map['firstName'] ?? '',
//       lastName: map['lastName'] ?? '',
//       id: map['id'] ?? '',
//       email: map['email'] ?? '',
//       phNumber: map['phNumber'],
//       profile: map['profile'] ?? '',
//       userType: map['userType'] ?? 'user',
//       isVerified: map['isVerified'] ?? false,
//       city: map['city'] ?? '',
//     );
//   }

//   bool get isProfileEmpty {
//     return profile == '';
//   }

//   bool get isUserTypeAdmin {
//     return userType == 'Admin';
//   }
// }