import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies/presentation/screen/splash_screen/splash.dart';
import '../../../core/local/shared_preference.dart';
import '../../../di.dart';
import '../../widgets/buttons/main_button.dart';
import '../../widgets/k_textfield.dart';
import '../../widgets/toasts/custom_toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  final AppPreferences _appPreferences = locator<AppPreferences>();
  FToast? fToast = FToast();

  String adminEmail = 'admin@gmail.com';
  String adminPassword = 'admin';

  _login() {
    if (formKey.currentState!.validate()) {
      if (emailCtrl.text == adminEmail && passwordCtrl.text == adminPassword) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setIsAdminLoggedIn();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const SplashScreen()));
        });
      } else if (emailCtrl.text == adminEmail &&
          passwordCtrl.text != adminPassword) {
        _showToast('Parolynyz yalnys!');
      } else if (emailCtrl.text != adminEmail &&
          passwordCtrl.text == adminPassword) {
        _showToast('Emailynyz yalnys!');
      } else {
        _showToast('Ikisem yalnys!');
      }
    }
  }

  @override
  void initState() {
    super.initState();

    fToast!.init(context);
  }

  @override
  dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              KTextField(
                controller: emailCtrl,
                isSubmitted: false,
                labelText: 'E-poctanyzy girizin',
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'doldurmaly';
                  } else if (val.length < 3) {
                    return '3 den kop bolmaly';
                  } else if (!RegExp(r'@[a-zA-Z]+\.[a-zA-Z]{2}')
                      .hasMatch(val)) {
                    return 'error';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              KTextField(
                controller: passwordCtrl,
                isSubmitted: false,
                keyboardType: TextInputType.visiblePassword,
                labelText: 'Parol girizin',
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Doldurmaly';
                  } else if (val.length < 3) {
                    return '3 den kop bolmaly';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              MainButton(
                onPressed: _login,
                buttonTile: 'Admin bolmak',
                width: size.width - 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showToast(String text) {
    Widget toast = ToastWidget(text: text);

    fToast!.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }
}
