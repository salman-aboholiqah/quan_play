// lib/core/di/service_locator.dart

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_player/core/database/objectbox_helper.dart';
import 'package:url_player/core/services/objectbox_service.dart';
import 'package:url_player/core/database/database_helper.dart';

import 'package:url_player/data/datasources/link_local_datasource.dart';
import 'package:url_player/data/repositories/link_repository_impl.dart';
import 'package:url_player/data/repositories/theme_repository_impl.dart';
import 'package:url_player/domain/repositories/link_repository.dart';
import 'package:url_player/domain/repositories/theme_repository.dart';
import 'package:url_player/presentation/bloc/cubit/theme_cubit.dart';
import 'package:url_player/presentation/bloc/link_bloc/link_bloc.dart';

import 'package:url_player/data/models/link_model.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // 🧱 ObjectBox service
  final objectBoxService = ObjectBoxService();
  await objectBoxService.init();
  sl.registerSingleton<ObjectBoxService>(objectBoxService);

  // 🗃️ Generic DB Helper for LinkModel
  final linkDbHelper = await ObjectBoxDatabaseHelper.create<LinkModel>(
    objectBoxService.store,
    LinkModel,
  );
  sl.registerSingleton<DatabaseHelper<LinkModel>>(linkDbHelper);

  // 📦 Local Data Source
  sl.registerLazySingleton(
    () => LinkLocalDataSource(sl<DatabaseHelper<LinkModel>>()),
  );

  // 📁 Repository
  sl.registerLazySingleton<LinkRepository>(() => LinkRepositoryImpl(sl()));
  sl.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(sharedPreferences: sl()),
  );

  // 🔄 BLoC
  sl.registerFactory(() => LinkBloc(sl()));

  // Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // 🌙 Theme Cubit
  sl.registerLazySingleton(() => ThemeCubit(sl()));
}
