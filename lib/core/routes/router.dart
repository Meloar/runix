import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:runix_project/features/auth/screen/login_screen.dart';
import 'package:runix_project/features/cart/screen/cart_screen.dart';
import 'package:runix_project/features/home/screen/category_screen.dart';
import 'package:runix_project/features/home/screen/home_screen.dart';
import 'package:runix_project/features/product/screen/product_screen.dart';
import 'package:runix_project/features/auth/screen/sign_up_screen.dart';
import 'package:runix_project/features/profile/screen/profile_screen.dart';
import 'package:runix_project/features/settings/screen/settings_screen.dart';

enum AppRoute {
  loginScreen,
  signUpScreen,
}

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
  '/sign-up': (_) => const MaterialPage(child: SignUpScreen()),
  '/home': (_) => const MaterialPage(child: HomeScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/product/:name': (route) => MaterialPage(
        child: ProductScreen(name: route.pathParameters['name']!),
      ),
  '/:category': (route) => MaterialPage(
        child: CategoryScreen(category: route.pathParameters['category']!),
      ),
  '/cart': (_) => MaterialPage(
        child: CartScreen(),
      ),
  '/settings': (_) => MaterialPage(
        child: SettingsScreen(),
      ),
  '/profile/:uid': (route) => MaterialPage(
        child: ProfileScreen(
          uid: route.pathParameters['uid']!,
        ),
      ),
});
