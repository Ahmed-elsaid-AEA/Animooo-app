import 'package:flutter/material.dart';

class AnimalPageController {
  BuildContext context;

  static AnimalPageController? _instance;

  AnimalPageController._internal(this.context) {
    print("animal page controller");
  }

  factory AnimalPageController(BuildContext context) {
    return _instance ??= AnimalPageController._internal(context);
  }
}
