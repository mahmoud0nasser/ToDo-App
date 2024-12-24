import 'package:get_it/get_it.dart';
import 'package:to_do_app/core/database/Cache/cache_helper.dart';
import 'package:to_do_app/core/database/sqflite_helper/sqflite_helper.dart';

final sl = GetIt.instance;
Future<void> setup() async {
  sl.registerLazySingleton<CacheHelper>(() => CacheHelper());
  sl.registerLazySingleton<SqfliteHelper>(() => SqfliteHelper());
//   getIt.registerSingleton<AppModel>(AppModel());

// // Alternatively you could write it if you don't like global variables
//   GetIt.I.registerSingleton<AppModel>(AppModel());
}