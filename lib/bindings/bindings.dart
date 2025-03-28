import 'package:get/get.dart';
import 'package:project_bc_tuto/utils/helpers/network_manager.dart';

class GeneralBindigs extends Bindings {

  @override
  void dependencies() {
    Get.put(NetworkManager());

  }
}