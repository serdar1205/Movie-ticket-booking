import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movies/app.dart';
import 'package:movies/presentation/screen/splash_screen/splash.dart';
import 'package:provider/provider.dart';
import 'core/config/theme/app_theme.dart';
import 'di.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  await GetStorage.init();
  runApp( const AppStart());
}

class AppStart extends StatelessWidget {
  const AppStart({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<ThemeProvider>(
          create: (_) => locator<ThemeProvider>()),
    ],
    child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: Provider.of<ThemeProvider>(context).theme,
            home: const SplashScreen(),
          );
        }
    ),);
  }
}

