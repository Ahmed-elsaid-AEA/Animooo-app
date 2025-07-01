//TODO don't forget to generate code automatically
class AuthResponse {
  //{
  //     "statusCode": 201,
  //     "message": "Signup successful!",
  //     "alert": "We send verfication code to your email",
  //     "user": {
  //         "id": 1,
  //         "first_name": "ahmed",
  //         "last_name": "elsaid",
  //         "email": "ahmed122727727@gmail.com",
  //         "phone": "201001398831",
  //         "image_path": "http://localhost:8000/api/uploads/1749539458120.png",
  //         "is_verified": "false"
  //     }

  int? statusCode;
  String? message;
  String? alert;
  UserResponseModel? user;

  AuthResponse({this.statusCode, this.message, this.alert, this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      alert: json['alert'],
      user: json['user'] != null
          ? UserResponseModel.fromJson(json['user'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    data['alert'] = alert;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'AuthResponse{statusCode: $statusCode, message: $message, alert: $alert, user: $user}';
  }
}

class UserResponseModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? imagePath;
  String? isVerified;

  UserResponseModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.imagePath,
    this.isVerified,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      imagePath: json['image_path'],
      isVerified: json['is_verified'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['image_path'] = imagePath;
    data['is_verified'] = isVerified;
    return data;
  }

  @override
  String toString() {
    return 'UserResponseModel{id: $id, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, imagePath: $imagePath, isVerified: $isVerified}';
  }
}
