import 'package:exam/views/home/home_page.dart';
import 'package:exam/views/likednotes/likenotes.dart';
import 'package:get/get.dart';

import '../views/splash/splash_page.dart';

class GetPages {
  static String splash = '/';
  static String home = '/home';
  static String likedNotes = '/likedNotes';

  static List<GetPage> getPages = [
    GetPage(
      name: splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: home,
      page: () => HomePage(),
    ),
    GetPage(
      name: likedNotes,
      page: () => const LikeNotesPage(),
    ),
  ];
}
