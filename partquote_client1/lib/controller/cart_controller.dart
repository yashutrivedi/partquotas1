import 'package:get/get.dart';
import 'package:partquote_client/model/cartmodel.dart';

class CartController extends GetxController {
  RxList<ShoppingItem> cart = RxList.empty();

  addTocart(ShoppingItem item) {
    var cartItem =
        cart.firstWhereOrNull((element) => element.name == item.name);
    if (cartItem == null) {
      cart.add(item);
    } else {
      var index = cart.indexWhere((element) => element.name == item.name);
      cart.removeAt(index);
      cartItem.quantity = cartItem.quantity + 1;
      cart.add(cartItem);
    }
  }
}
