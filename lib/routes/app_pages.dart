import 'package:get/get.dart';

import '../features/home/presentation/pages/home_page.dart';
import '../features/home/presentation/bindings/home_binding.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
