import 'package:flutter/material.dart';

import '../../main.dart';


class Routes {
  static const String initialRoute = '/';
  static const String addUpdateScreenRoute = 'addUpdateScreenRoute';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: ((context) => const MyApp()));
    }

    return undefinedRoute();
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text('No Route'),
              ),
            )));
  }
}

// final Map<String,dynamic> routes = {
//   Routes.initialRoute: (context) => const QuoteScreen(),
//   '/testScreen' : (context)   => const TestRout()
// };
