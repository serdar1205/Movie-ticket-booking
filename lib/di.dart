import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies/data/repository/repositories.dart';
import 'package:movies/presentation/controller/admin_controller.dart';
import 'package:movies/presentation/controller/app_contoller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/config/theme/app_theme.dart';
import 'core/local/shared_preference.dart';
import 'data/data_source/local_datasource/app_database.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  ///theme
  locator.registerLazySingleton<ThemeServices>(() => ThemeServices());
  locator.registerLazySingleton<ThemeProvider>(() => ThemeProvider());

  final sharedPrefs = await SharedPreferences.getInstance();

  // shared prefs instance
  locator.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  locator
      .registerLazySingleton<AppPreferences>(() => AppPreferences(locator()));

  //image
  locator.registerFactory<ImagePicker>(() => ImagePicker());

  //db
  final database = await $FloorAppDatabase.databaseBuilder('films.db').build();
  locator.registerSingleton<AppDatabase>(database);

  //repo
  locator.registerLazySingleton<FilmRepository>(
      () => FilmRepository(appDatabase: locator()));

  //provider
  locator.registerFactory(() => AdminController());
  locator.registerFactory(() => AppController());

}
