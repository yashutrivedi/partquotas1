import 'package:get/get.dart';
import 'package:partquote_client/Screens/cartpage.dart';
import 'package:partquote_client/config/app_routes.dart';

class AppScreens {
  static const Transition _transition = Transition.fade;

  static var list = [
    GetPage(
        name: AppRoutes.cartscreen,
        page: () => CartPage(),
        transition: _transition),
  ];
}
