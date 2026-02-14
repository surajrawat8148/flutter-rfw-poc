import 'package:get/get.dart';

import '../features/home/presentation/pages/home_page.dart';
import '../features/home/presentation/bindings/home_binding.dart';
import '../features/auth/presentation/pages/rfw_auth_page.dart';
import '../features/auth/presentation/bindings/auth_binding.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/dashboard/presentation/bindings/dashboard_binding.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.AUTH;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.AUTH,
      page: () => const RfwAuthPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),
  ];
}
