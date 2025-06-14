import 'package:animooo/core/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class AnimoooApp extends StatelessWidget {
  const AnimoooApp({super.key});
   @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesManager.onGenerateRoute,
    );

  }


}
