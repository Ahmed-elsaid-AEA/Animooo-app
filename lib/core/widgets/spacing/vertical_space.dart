import 'package:flutter/material.dart';

class VerticalSpace extends StatelessWidget {
  const VerticalSpace({super.key, required this.height});
final double height;
  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      height: height,
    );
  }
}
