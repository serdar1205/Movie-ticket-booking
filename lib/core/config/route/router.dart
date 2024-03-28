// import 'package:flutter/material.dart';
// import 'package:movies/app.dart';
// import 'package:movies/presentation/screen/main_page/main_page.dart';
//
// import '../../constants/strings/app_strings.dart';
//
// class Routes {
//   static const String splashRoute = "/";
//   static const String onBoardingRoute = "/onBoarding";
//   static const String loginRoute = "/login";
//   static const String registerRoute = "/register";
//   static const String forgotPasswordRoute = "/forgotPassword";
//   static const String mainRoute = "/main";
//   static const String storeDetailsRoute = "/storeDetails";
// }
//
// class RouteGenerator {
//   static Route<dynamic> getRoute(RouteSettings routeSettings) {
//     switch (routeSettings.name) {
//       case Routes.splashRoute:
//         return MaterialPageRoute(builder: (_) => const AppStart());
//
//       default:
//         return unDefinedRoute();
//     }
//   }
//
//   static Route<dynamic> unDefinedRoute() {
//     return MaterialPageRoute(
//         builder: (_) => Scaffold(
//             appBar: AppBar(
//               title:  Text("NO"),//.tr(),
//             ),
//             body: const Center(child: Text("NO"),//.tr()),
//             )));
//   }
// }