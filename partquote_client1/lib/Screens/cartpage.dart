import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partquote_client/Screens/user_service.dart';
import 'package:partquote_client/controller/cart_controller.dart';
import 'package:partquote_client/controller/quotation_controller.dart';
import 'package:partquote_client/model/cartmodel.dart';
import 'package:partquote_client/Screens/quotationstatus.dart';
import 'package:partquote_client/model/detailsmodel.dart';
import 'dashboard.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find<CartController>();
    QuotationController quotationController = Get.find<QuotationController>();
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait = screenSize.height > screenSize.width;

    double findTotal() {
      double total = 0;
      cartController.cart.forEach((element) {
        total += element.quantity * element.price;
      });

      return total;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Page"),
        actions: [
          IconButton(
            onPressed: () {
              quotationController.addQuotation(
                QuotationItem(
                  quotationBy: UserService.getUser()!.name,
                  date: DateTime.now().toIso8601String(),
                  status: false,
                  items:
                      ShoppingItem.convertItemsToMapList(cartController.cart),
                ),
              );
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
              style: TextStyle(
                fontSize: isPortrait ? 20 : 24,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartController.cart.length,
              itemBuilder: (context, index) {
                final item = cartController.cart[index];
                var total = item.price * item.quantity;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(item.name),
                      ),
                      Spacer(),
                      SizedBox(
                        width: isPortrait ? 80 : 120,
                        child: TextFormField(
                          initialValue: item.quantity.toString(),
                          decoration: InputDecoration(
                            hintText: 'Quantity',
                            contentPadding: EdgeInsets.all(5),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            cartController.cart[index].quantity =
                                int.parse(value);
                            cartController.cart.refresh();
                          },
                        ),
                      ),
                      Spacer(),
                      Text('${item.price}'),
                      Spacer(),
                      Text(total.toString()),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Items: ${cartController.cart.length}"),
                Text("Total Amount: ${findTotal()}"),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClientDashboard()),
              );
            },
            child: Text("Cancel"),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
