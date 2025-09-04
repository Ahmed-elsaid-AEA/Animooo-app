import 'package:animooo/core/database/api/dio_service.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void getItSetup() {
  getIt.registerLazySingleton<GlobalKey<NavigatorState>>(
    () => GlobalKey<NavigatorState>(),
    instanceName:ConstsValuesManager.homePageNavigationState,
  );
  getIt.registerLazySingleton<GlobalKey<NavigatorState>>(
    () => GlobalKey<NavigatorState>(),
    instanceName:ConstsValuesManager.searchPageNavigationState,
  );
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<DioService>(() => DioService(getIt<Dio>()));
}
