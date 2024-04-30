import 'package:flutter/material.dart';
import 'package:partquote_client/model/detailsmodel.dart';
// Import the model

class Quotation_details extends StatelessWidget {
  const Quotation_details({Key? key});

  @override
  Widget build(BuildContext context) {
    // final List<QuotationItem> quotationItems = [
    //   QuotationItem(
    //     itemName: "Break",
    //     quantity: "3",
    //     originalPrice: "600 rs.",
    //     changedPrice: "550 rs.",
    //   ),
    //   QuotationItem(
    //     itemName: "tayers",
    //     quantity: "4",
    //     originalPrice: "2000 rs.",
    //     changedPrice: "2000 rs.",
    //   ),
    //   QuotationItem(
    //     itemName: "seat covers",
    //     quantity: "6",
    //     originalPrice: "300 rs.",
    //     changedPrice: "250 rs.",
    //   ),
    //   QuotationItem(
    //     itemName: "front head Lights",
    //     quantity: "4",
    //     originalPrice: "400 rs.",
    //     changedPrice: "390 rs.",
    //   ),
    //   QuotationItem(
    //     itemName: "sidelights",
    //     quantity: "2",
    //     originalPrice: "600 rs.",
    //     changedPrice: "555 rs.",
    //   ),
    //   QuotationItem(
    //     itemName: "horn",
    //     quantity: "5",
    //     originalPrice: "500 rs.",
    //     changedPrice: "500 rs.",
    //   ),
    // ];

    int totalQuantity = 0;
    double totalOriginalPrice = 0;
    double totalChangedPrice = 0;

    // for (var item in quotationItems) {
    //   totalQuantity += int.parse(item.quantity);
    //   totalOriginalPrice +=
    //       double.parse(item.originalPrice.replaceAll(' rs.', ''));
    //   totalChangedPrice +=
    //       double.parse(item.changedPrice.replaceAll(' rs.', ''));
    // }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Quotation Details')),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Qno.-1'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('12/02/2024'),
                  ),
                )
              ],
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: quotationItems.length,
            //     itemBuilder: (context, index) {
            //       final item = quotationItems[index];
            //       return ListTile(
            //         title: Text(item.itemName),
            //         subtitle: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text('${item.quantity}'),
            //             Text('${item.originalPrice}'),
            //             Text('${item.changedPrice}'),
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('$totalQuantity'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(' $totalOriginalPrice rs.'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(' $totalChangedPrice rs.'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
