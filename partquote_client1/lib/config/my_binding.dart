import 'package:get/get.dart';
import 'package:partquote_client/controller/cart_controller.dart';
import 'package:partquote_client/controller/quotation_controller.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CartController());
    Get.lazyPut(()=>QuotationController(),fenix: true);

    // Get.put(RegistrationController());
  }
}
