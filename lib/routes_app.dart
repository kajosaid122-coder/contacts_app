import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'splash_screen.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    SplashScreen.routeName: (context) => const SplashScreen(),
    HomeScreen.routeName: (context) => const HomeScreen(),
  };
}
