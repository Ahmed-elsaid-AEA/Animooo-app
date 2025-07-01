import 'package:json_annotation/json_annotation.dart';

part 'failure_model.g.dart';

@JsonSerializable()
class FailureModel {
  @JsonKey(name: 'error')
  List<String> errors;
  int statusCode;

  FailureModel({required this.errors, required this.statusCode});

  factory FailureModel.fromJson(Map<String, dynamic> json) =>
      _$FailureModelFromJson(json);

  Map<String, dynamic> toJson() => _$FailureModelToJson(this);
}
