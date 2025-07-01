
import 'dart:io';

class UserModel{
  String firstName;
  String lastName;
  String email;
  String phone;
  String password;
  File image;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.image,
  });



}