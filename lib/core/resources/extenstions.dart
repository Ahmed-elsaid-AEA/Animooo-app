import 'package:flutter/material.dart';

extension TextEditingControllerExtension on TextEditingController {
  String get getText => text.trim();

}
