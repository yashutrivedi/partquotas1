import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partquote_client/Screens/detailpage.dart';
import 'package:partquote_client/Screens/statumodel.dart';
import 'package:partquote_client/controller/quotation_controller.dart';
import 'package:partquote_client/model/cartmodel.dart';

class QuotationStatus extends StatelessWidget {
  const QuotationStatus({super.key});

  @override
  Widget build(BuildContext context) {
    QuotationController quotationController = Get.find<QuotationController>();

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Item Details')),
      ),
      body: Obx(() => ListView.builder(
          itemCount: quotationController.quotation.length,
          itemBuilder: (context, index) {

            
          return  Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuotationDetailPage(
                          quotationStatusItem:
                              ShoppingItem.convertMapListToItems(
                                  quotationController.quotation[index].items)),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1),
                  ),
                  height: 80,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 80, // Adjusted height to match the row height
                        width: 40,
                        decoration: BoxDecoration(
                          color: quotationController.quotation[index].status ==
                                  false
                              ? Colors.red
                              : Colors.green,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Text(quotationStatusItems[index].quotationNumber),
                              Text(
                                " Date: ${quotationController.quotation[index].date.substring(0, 10)}",
                              ),
                              // Text(
                              //   "${quotationStatusItems[index].date.day.toString().padLeft(2, '0')}/${quotationStatusItems[index].date.month.toString().padLeft(2, '0')}/${quotationStatusItems[index].date.year}",
                              // ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                " qty: ${quotationController.quotation[index].items.length.toString()}",
                              ),
                              Text(
                                  "Total Price:  ${quotationController.findTotal(ShoppingItem.convertMapListToItems(quotationController.quotation[index].items))}")

                              // Text(quotationController.quotation[index].items[]),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.delete),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          })),
    );
  }
}
