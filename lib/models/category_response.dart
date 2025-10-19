import 'package:json_annotation/json_annotation.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  int statusCode;
  @JsonKey(name: "Category")
  CategoryInfoModel category;
  String message;

  CategoryResponse({
    required this.statusCode,
    required this.category,
    required this.message,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}

@JsonSerializable()
class CategoryInfoModel {
  final int id;
  final String name;
  final String description;
  final String imagePath;
  final String createdAt;
  final String updatedAt;
  final int userId;

  CategoryInfoModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  factory CategoryInfoModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryInfoModelToJson(this);
}
