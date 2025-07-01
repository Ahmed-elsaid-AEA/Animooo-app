class FailureModel {
  List<String> errors;
  int statusCode;

  FailureModel({required this.errors, required this.statusCode});

  factory FailureModel.fromJson(Map<String, dynamic> json) {
     return FailureModel(
      errors: json['error'] == null
          ? []
          : List<String>.from(json["error"].map((x) => x)),
      statusCode: json["statusCode"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "errors": List<dynamic>.from(errors.map((x) => x)),
      "statusCode": statusCode,
    };
  }
}
