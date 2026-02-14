import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rfw/rfw.dart';
import '../../../../core/rfw/rfw_runtime_manager.dart';
import '../controllers/dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text('Error: ${controller.errorMessage.value}'));
        }

        return RemoteWidget(
          runtime: RfwRuntimeManager().runtime,
          data: RfwRuntimeManager().data,
          widget: const FullyQualifiedWidgetName(
            LibraryName(['dashboard']),
            'main',
          ),
          onEvent: controller.onEvent,
        );
      }),
    );
  }
}
