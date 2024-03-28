import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movies/app.dart';
import '../../../core/local/shared_preference.dart';
import '../../../di.dart';
import '../../../main.dart';

bool isAdmin = false;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  final AppPreferences _appPreferences = locator<AppPreferences>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() {
    _appPreferences
        .isAdminLoggedIn()
        .then((isAdminLoggedIn) => {isAdmin = isAdminLoggedIn});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MyApp()));
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          image: AssetImage('assets/logo/logo.jpg'),
        ),
      ),
    );
  }
}
