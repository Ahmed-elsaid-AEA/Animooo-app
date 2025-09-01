import 'package:animooo/core/di/get_it.dart';
 import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/animooo_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  getItSetup();
  runApp(const AnimoooApp());
}
