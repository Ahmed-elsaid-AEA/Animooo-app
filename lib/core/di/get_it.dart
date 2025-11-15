import 'package:animooo/core/database/api/dio_service.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/flutter_secure/flutter_scs_manager.dart';
import '../database/shared_pref/shared_pref_manager.dart';

final GetIt getIt = GetIt.instance;

Future<void> getItSetup() async {
  getIt.registerLazySingleton<GlobalKey<NavigatorState>>(
    () => GlobalKey<NavigatorState>(),
    instanceName: ConstsValuesManager.homePageNavigationState,
  );
  getIt.registerLazySingleton<GlobalKey<NavigatorState>>(
    () => GlobalKey<NavigatorState>(),
    instanceName: ConstsValuesManager.searchPageNavigationState,
  );
  getIt.registerLazySingleton<GlobalKey<NavigatorState>>(
    () => GlobalKey<NavigatorState>(),
    instanceName: ConstsValuesManager.appNavigationState,
  );
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<DioService>(() => DioService(getIt<Dio>()));
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);
  getIt.registerLazySingleton<SharedPrefManager>(
    () => SharedPrefManager(getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => FlutterSecureStorage(),
  );
  getIt.registerLazySingleton<FlutterSecureStorageManager>(
    () => FlutterSecureStorageManager(getIt<FlutterSecureStorage>()),
  );
}
