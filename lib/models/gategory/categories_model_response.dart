// {
// "statusCode": 200,
// "Categories": [
// {
// "id": 1,
// "name": "dogs",
// "description": "this dogs",
// "imagePath": "http://localhost:8000/api/uploads/1749634998420.png",
// "createdAt": "2025-06-11 12:43:18.000Z",
// "updatedAt": "2025-06-11 12:43:18.000Z",
// "userId": 1
// }
// ]
// }
import 'package:animooo/models/gategory/category_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categories_model_response.g.dart';

@JsonSerializable()
class CategoriesModelResponse {
  final int statusCode;
  @JsonKey(name: "Categories")
  final List<CategoryInfoModel> categories;

  CategoriesModelResponse({required this.statusCode, required this.categories});

  factory CategoriesModelResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesModelResponseToJson(this);
  @override
  String toString() {
    return 'CategoriesModelResponse{statusCode: $statusCode, categories: $categories}';
  }
}
