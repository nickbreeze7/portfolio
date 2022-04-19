import 'package:get/get.dart';

import '../core/viewmodel/auth_viewmodel.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.put(CartViewModel());
    Get.lazyPut(() => NetworkViewModel());
  }
}
