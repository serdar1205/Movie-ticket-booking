import 'package:flutter/material.dart';
import 'package:movies/core/constants/sizes/app_text_size.dart';
import 'package:movies/presentation/controller/app_contoller.dart';
import 'package:movies/presentation/screen/admin/add_film/add_film.dart';
import 'package:movies/presentation/screen/admin/admin_page/added_films_page.dart';
import 'package:movies/presentation/screen/favorites_page/favorites_page.dart';
import 'package:movies/presentation/screen/history_page/history_page.dart';
import 'package:movies/presentation/screen/login_page/login_page.dart';
import 'package:movies/presentation/screen/main_page/main_page.dart';
import 'package:movies/presentation/widgets/bottom_navigation.dart';
import 'package:movies/presentation/screen/splash_screen/splash.dart';
import 'core/config/theme/app_theme.dart';
import 'core/local/shared_preference.dart';
import 'di.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = locator<AppPreferences>();

  final List<Widget> pages = [
    const MainPage(),
    const FavoritesPage(),
     const HistoryPage(),
    const LoginPage(),
  ];
  final List<Widget> adminPages = [
    const AddedFilmsPage(),
    const AddFilmPage(),
  ];

  final List<String> appBarTitle = [
    "Baş sahypa",
    "Halanlarym",
    "Alnan biletler",
    "Admin",
  ];
  final List<String> adminTitles = ["Kinolar", 'Kino gosmak'];

  int index = 0;

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isAdmin ? adminTitles[index] : appBarTitle[index]),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  //locator<ThemeServices>().switchTheme();
                  locator<ThemeProvider>().toggleTheme();
                },
                icon: const Icon(Icons.wb_sunny_outlined)),
          ),
          isAdmin
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: _showDialog, icon: const Icon(Icons.logout)),
                )
              : const SizedBox(),
          if (isAdmin == false && index == 2)
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
              child: IconButton(
                  onPressed: _showDialogD, icon: const Icon(Icons.delete)),
            )
        ],
      ),
      body: isAdmin ? adminPages[index] : pages[index],
      bottomNavigationBar: BottomNavBar(
        isAdmin: isAdmin,
        pageIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }

  void _logout() {
    _appPreferences.logout();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreen()),
        (Route<dynamic> route) => false);
  }

  void _showDialogD() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //backgroundColor: AppColors.cardColor3,
        elevation: 8,
        content: BigText('Ahli biletleri ocurjekmi?', context: context),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: MediumText(
                  'Yok',
                  context: context,
                ),
              ),
              TextButton(
                onPressed: () => {
                  locator<AppController>().deleteAllTickets(),
                  Navigator.pop(context),
                },
                child: MediumText(
                  'Hawa',
                  context: context,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }


  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //backgroundColor: AppColors.cardColor3,
        elevation: 8,
        content: BigText('Siz cykjakmy?', context: context),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: MediumText(
                  'Yok',
                  context: context,
                ),
              ),
              TextButton(
                onPressed: _logout,
                child: MediumText(
                  'Hawa',
                  context: context,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
