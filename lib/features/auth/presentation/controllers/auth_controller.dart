import 'package:get/get.dart';
import '../../../../core/rfw/rfw_runtime_manager.dart';
import '../../data/auth_api_service.dart';
import '../../../../routes/app_pages.dart';

class AuthController extends GetxController {
  final AuthApiService _apiService = AuthApiService();
  final RfwRuntimeManager _rfwManager = RfwRuntimeManager();

  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUI('/ui/register');
  }

  Future<void> fetchUI(String endpoint) async {
    try {
      isLoading(true);
      final bytes = await _apiService.fetchUI(endpoint);
      _rfwManager.updateLibraryFromBytes('auth', bytes);
      isLoading(false);
    } catch (e) {
      isLoading(false);
      errorMessage(e.toString());
    }
  }

  void onEvent(String name, Map<String, Object?> arguments) async {
    switch (name) {
      case 'register':
        await _register(arguments);
        break;
      case 'login':
        await _login(arguments);
        break;
      case 'goToLogin':
        await fetchUI('/ui/login');
        break;
      case 'goToRegister':
        await fetchUI('/ui/register');
        break;
      default:
        print('Unknown event: $name');
    }
  }

  Future<void> _register(Map<String, Object?> arguments) async {
    try {
      isLoading(true);
      final success = await _apiService.register({
        'phoneNumber': arguments['phone'],
        'password': arguments['password'],
      });
      if (success) {
        Get.offAllNamed(Routes.DASHBOARD);
      } else {
        errorMessage('Registration failed');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> _login(Map<String, Object?> arguments) async {
    try {
      isLoading(true);
      final success = await _apiService.login({
        'phoneNumber': arguments['phone'],
        'password': arguments['password'],
      });
      if (success) {
        Get.offAllNamed(Routes.DASHBOARD);
      } else {
        errorMessage('Login failed');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
