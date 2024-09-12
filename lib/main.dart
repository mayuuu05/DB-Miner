import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app_with_sqldb/view/detail/detail_page.dart';
import 'package:quotes_app_with_sqldb/view/edit/edit_quotes.dart';
import 'package:quotes_app_with_sqldb/view/favourite/favourite.dart';
import 'package:quotes_app_with_sqldb/view/home/home_screen.dart';
import 'package:quotes_app_with_sqldb/view/splashScreen/splash_screen.dart';

void main() {
  runApp(const QuotesApp());
}

class QuotesApp extends StatelessWidget {
  const QuotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => SplashScreen(),
          transition: Transition.circularReveal
        ),
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
        ),
        GetPage(
          name: '/cat',
          page: () => CategoryPage(),
        ),
        GetPage(
          name: '/edit',
          page: () => EditQuotes(),
        ),
        GetPage(
          name: '/fav',
          page: () => const LikedQuotesScreen(),
        ),
      ],
    );
  }
}
