import 'package:get/get.dart';
import '../../../../core/rfw/rfw_runtime_manager.dart';
import '../../../auth/data/auth_api_service.dart';

class DashboardController extends GetxController {
  final AuthApiService _apiService = AuthApiService();
  final RfwRuntimeManager _rfwManager = RfwRuntimeManager();

  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUI();
  }

  Future<void> fetchUI() async {
    try {
      isLoading(true);
      final bytes = await _apiService.fetchUI('/ui/dashboard');
      _rfwManager.updateLibraryFromBytes('dashboard', bytes);
      isLoading(false);
    } catch (e) {
      isLoading(false);
      errorMessage(e.toString());
    }
  }

  void onEvent(String name, Map<String, Object?> arguments) {
    // Handle dashboard events if any
    print('Dashboard event: $name');
  }
}
